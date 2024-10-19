//
//  MockRecipesFetcher.swift
//  FetchRecipesTests
//
//  Created by Oren Leavitt on 10/17/24.
//

import Foundation

class MockRecipesFetcher: RecipesFetcher {
  
    let allRecipesJson =
"""
{
    "recipes": [
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        },
        {
            "cuisine": "British",
            "name": "Apple & Blackberry Crumble",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
            "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
            "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
        },
        {
            "cuisine": "British",
            "name": "Apple Frangipan Tart",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
            "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
            "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
        },
        {
            "cuisine": "American",
            "name": "Banana Pancakes",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
            "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
            "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
        },
        {
            "cuisine": "Canadian",
            "name": "BeaverTails",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/3b33a385-3e55-4ea5-9d98-13e78f840299/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/3b33a385-3e55-4ea5-9d98-13e78f840299/small.jpg",
            "source_url": "https://www.tastemade.com/videos/beavertails",
            "uuid": "b5db2c09-411e-4bdf-9a75-a194dcde311b",
            "youtube_url": "https://www.youtube.com/watch?v=2G07UOqU2e8"
        }
    ]
}    
"""
    
    let malformedRecipesJson =
"""
{
    "recipes": [
        {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        },
        {
            "cuisine": "American",
            "name": "Banana Pancakes",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
            "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
            "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
        },
        {
            "cuisine": "British",
            "name": "Battenberg Cake",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/ec1b84b1-2729-4547-99db-5e0b625c0356/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/ec1b84b1-2729-4547-99db-5e0b625c0356/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/1120657/battenberg-cake",
            "uuid": "891a474e-91cd-4996-865e-02ac5facafe3",
            "youtube_url": "https://www.youtube.com/watch?v=aB41Q7kDZQ0"
        },
        {
            "cuisine": "Canadian",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/1837/canadian-butter-tarts",
            "uuid": "39ad8233-c470-4394-b65f-2a6c3218b935"
        },
        {
            "cuisine": "British",
            "name": "Chelsea Buns",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/4aecd46e-e419-49ec-8888-246b3cc0cc94/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/4aecd46e-e419-49ec-8888-246b3cc0cc94/small.jpg",
            "source_url": "https://www.bbc.co.uk/food/recipes/chelsea_buns_95015",
            "uuid": "7fc217a9-5566-4bf1-b1ce-13bc9e3f2b1a",
            "youtube_url": "https://www.youtube.com/watch?v=i_zemP3yBKw"
        }
    ]
}
"""
    
    let emptyRecipesJson =
"""
{
    "recipes": []
}
"""
    
    func getRecipes(endPoint: RecipesEndPoint) async throws -> [Recipe] {
        guard let url = URL(string: endPoint.rawValue) else {
            print("Malformed URL")
            return []
        }
        
        let jsonString: String
        switch endPoint {
        case .allRecipes:
            jsonString = allRecipesJson
        case .malformed:
            jsonString = malformedRecipesJson
        case .empty:
            jsonString = emptyRecipesJson
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            print("Couldn't convert string JSON to data")
            return []
        }
        let recipesObject = try JSONDecoder().decode(Recipes.self, from: data)

        return recipesObject.recipes
    }
}
