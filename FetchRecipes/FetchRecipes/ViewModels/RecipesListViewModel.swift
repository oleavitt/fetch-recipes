//
//  RecipesListViewModel.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/7/24.
//

import Foundation

class RecipesListViewModel: ObservableObject {
    
    enum State {
        case loading, empty, foooood, error
    }

    @Published var state: State = .empty
    @Published var recipes: [Recipes] = []
    
    private var error: Error?
    
    init() {
        
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
