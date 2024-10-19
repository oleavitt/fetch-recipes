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
            .task {
                await viewModel.fetchRecipes()
            }
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
            ForEach(viewModel.recipeCuisines, id: \.self) { recipe in
                HStack {
                    VStack {
                        Text(recipe)
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
