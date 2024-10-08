//
//  RecipesListViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Oren Leavitt on 10/8/24.
//

import XCTest

final class RecipesListViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyInit() throws {
        let viewModel = RecipesListViewModel()
        
        XCTAssert(viewModel.state == .empty)
        XCTAssert(viewModel.recipes.isEmpty)
        XCTAssert(viewModel.errorMessage.isEmpty)
    }
}
