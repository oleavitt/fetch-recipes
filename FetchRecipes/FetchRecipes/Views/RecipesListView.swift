//
//  RecipesListView.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/7/24.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var viewModel = RecipesListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .empty:
                    noRecipesView
                case .loading:
                    ProgressView("loading_text")
                case .foooood:
                    Text("Recipes!")
                case .error:
                    errorView
                }
            }
            .navigationTitle("main_title".localized())
        }
    }
    
    var noRecipesView: some View {
        Text("empty_recipe_list_placeholder".localized())
            .multilineTextAlignment(.center)
            .font(.title3)
    }
    
    var errorView: some View {
        Text(viewModel.errorMessage)
    }
}

#Preview {
    RecipesListView()
}
