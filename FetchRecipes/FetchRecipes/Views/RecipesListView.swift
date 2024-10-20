//
//  RecipesListView.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/7/24.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var viewModel = RecipesListViewModel(fetcher: NetworkRecipesFetcher())
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .empty:
                    noRecipesView
                case .loading:
                    ProgressView("loading_text")
                case .loaded:
                    recipesView
                case .error:
                    errorView
                }
            }
            .navigationTitle("main_title".localized())
            .task(viewModel.loadRecipes)
            .refreshable(action: viewModel.fetchRecipes)
        }
    }
    
    var noRecipesView: some View {
        List {
            Text("empty_recipe_list_placeholder".localized())
                .multilineTextAlignment(.center)
                .font(.title3)
        }
    }
    
    var recipesView: some View {
        List {
            ForEach(viewModel.recipeCuisines, id: \.self) { cuisine in
                Section(cuisine) {
                    ForEach(viewModel.recipesFor(cuisine: cuisine), id: \.self) { recipe in
                        RecipeRowView(recipe: recipe)
                    }
                }
            }
        }
    }
    
    var errorView: some View {
        List {
            HStack(alignment: .top) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    RecipesListView()
}
