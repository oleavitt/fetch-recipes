//
//  RecipesListViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Oren Leavitt on 10/8/24.
//

import XCTest
@testable import FetchRecipes

final class RecipesListViewModelTests: XCTestCase {
    
    var viewModel = RecipesListViewModel(fetcher: MockRecipesFetcher())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RecipesListViewModel(fetcher: MockRecipesFetcher())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyInit() throws {
        XCTAssert(viewModel.state == .empty)
        XCTAssert(viewModel.recipesList.isEmpty)
        XCTAssert(viewModel.recipeCuisines.isEmpty)
        XCTAssert(viewModel.errorMessage.isEmpty)
    }
    
    func testFetchRecipesEmpty() async throws {
        viewModel.selectedEndPoint = .empty
        await viewModel.fetchRecipes()
        
        XCTAssert(viewModel.state == .empty)
        XCTAssert(viewModel.recipesList.isEmpty)
        XCTAssert(viewModel.recipeCuisines.isEmpty)
        XCTAssert(viewModel.errorMessage.isEmpty)
    }
    
    func testFetchRecipes() async throws {
        viewModel.selectedEndPoint = .allRecipes
        await viewModel.fetchRecipes()
        
        XCTAssert(viewModel.state == .loaded)
        XCTAssertEqual(viewModel.recipesList.count, 5)
        XCTAssertEqual(viewModel.recipeCuisines.count, 4)
        XCTAssert(viewModel.errorMessage.isEmpty)
        
        let firstRecipe = viewModel.recipesList.first
        XCTAssertEqual(firstRecipe?.cuisine, "Malaysian")
        XCTAssertEqual(firstRecipe?.name, "Apam Balik")
        XCTAssertEqual(firstRecipe?.photoUrlLarge, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        XCTAssertEqual(firstRecipe?.photoUrlSmall, "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        XCTAssertEqual(firstRecipe?.sourceUrl, "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ")
        XCTAssertEqual(firstRecipe?.videoUrl, "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        XCTAssertEqual(firstRecipe?.uuid, UUID(uuidString: "0c6ca6e7-e32a-4053-b824-1dbf749910d8"))

        XCTAssertEqual(viewModel.recipeCuisines.first, "American")
        XCTAssertEqual(viewModel.recipeCuisines.last, "Malaysian")
    }
    
    func testFetchRecipesMalformed() async throws {
        viewModel.selectedEndPoint = .malformed
        await viewModel.fetchRecipes()
        
        XCTAssert(viewModel.state == .error)
        XCTAssert(viewModel.recipesList.isEmpty)
        XCTAssert(viewModel.recipeCuisines.isEmpty)
        XCTAssertFalse(viewModel.errorMessage.isEmpty)
    }
    
    func testRecipesForCuisine() async throws {
        viewModel.selectedEndPoint = .allRecipes
        await viewModel.fetchRecipes()
        
        let recipesBritish = viewModel.recipesFor(cuisine: "British")
        XCTAssertEqual(recipesBritish.count, 2)
        XCTAssertEqual(recipesBritish.first?.name, "Apple & Blackberry Crumble")
        
        XCTAssert(viewModel.recipesFor(cuisine: "Martian").isEmpty)
    }
}
