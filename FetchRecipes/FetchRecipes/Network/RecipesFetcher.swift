//
//  RecipesFetcher.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/8/24.
//

import Foundation
import Combine

enum RecipesEndPoint: String {
    case allRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case malformed = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    case empty = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}

protocol RecipesFetcher {
    func getRecipes(endPoint: RecipesEndPoint) async throws -> [Recipe]
}

class NetworkRecipesFetcher: RecipesFetcher {
    
    func getRecipes(endPoint: RecipesEndPoint) async throws -> [Recipe] {
        guard let url = URL(string: endPoint.rawValue) else {
            print("Malformed URL")
            return []
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipesObject = try JSONDecoder().decode(Recipes.self, from: data)

        return recipesObject.recipes
    }
}
