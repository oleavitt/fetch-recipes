//
//  RecipesListViewModel.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/7/24.
//

import Foundation

class RecipesListViewModel: ObservableObject {
    
    private let fetcher: RecipesFetcher

    @Published var state: State = .empty
    @Published var recipesList: [Recipe] = []
    
    enum State {
        case loading, loaded, empty, error
    }
    
    private var error: Error?
    
    var selectedEndPoint: RecipesEndPoint = .allRecipes
    
    init(fetcher: RecipesFetcher) {
        self.fetcher = fetcher
    }

    var recipeCuisines: [String] {
        Set(recipesList.map {
            $0.cuisine
        }).sorted()
    }
    
    func recipesFor(cuisine: String) -> [Recipe] {
        recipesList.filter { $0.cuisine == cuisine }
            .sorted { $0.name < $1.name }
    }
    
    @Sendable
    @MainActor
    func fetchRecipes() async {
        error = nil
        
        // Uncomment to add a 3 second delay - just to show the loading state
        try? await Task.sleep(nanoseconds: 1_000_000_000 * 3)
        
        do {
            recipesList = try await fetcher.getRecipes(endPoint: selectedEndPoint)
            state = recipesList.isEmpty ? .empty : .loaded
            print("fetchRecipes(): Received \(recipesList.count) recipes")
        } catch {
            print("fetchRecipes(): \(error.localizedDescription)")
            self.error = error
            state = .error
        }
    }
    
    @Sendable
    @MainActor
    func loadRecipes() async {
        state = .loading
        await fetchRecipes()
    }
    
    var errorMessage: String {
        guard let error else { return "" }
#if DEBUG
        return "error_message_unable_to_load".localized() + "\n" +
        error.localizedDescription
#else
        return "error_message_unable_to_load".localized()
#endif
    }
}

private extension RecipesListViewModel {
    
    func handleFetchRecipesResponse(recipes: [Recipe], error: Error?) {
        if let error {
            self.error = error
            state = .error
        } else {
            if recipes.isEmpty {
                state = .empty
            }
            recipesList = recipes
        }
    }
}
