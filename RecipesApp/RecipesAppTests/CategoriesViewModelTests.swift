//
//  CategoriesViewModelTests.swift
//  RecipesAppTests
//
//  Created by andres paladines on 8/23/23.
//

import XCTest
@testable import RecipesApp

final class CategoriesViewModelTests: XCTestCase {

    var categoriesViewModel: CategoriesViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
       
    }

    func testApiCallOk() {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        fakeNetworkManager.useCase = .categoriesFullList
        categoriesViewModel = CategoriesViewModel(networkManager: fakeNetworkManager)
        
        //When
        categoriesViewModel.fetchAllCategories()
        let expectation = XCTestExpectation(description: "Fetching Categories list with correct data")
        let waitDuration = 0.1

        //Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.categoriesViewModel)
            XCTAssertEqual(self.categoriesViewModel.categoriesListFiltered.count, 5)
            XCTAssertNil(self.categoriesViewModel.customError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallEmptyList() {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        fakeNetworkManager.useCase = .emptyList
        categoriesViewModel = CategoriesViewModel(networkManager: fakeNetworkManager)
        
        //When
        categoriesViewModel.fetchAllCategories()
        let expectation = XCTestExpectation(description: "Fetching Categories with empty list")
        let waitDuration = 1.0

        //Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.categoriesViewModel)
            XCTAssertEqual(self.categoriesViewModel.categoriesListFiltered.count, 0)
            XCTAssertNotNil(self.categoriesViewModel.customError)
            XCTAssertEqual(self.categoriesViewModel.customError, .dataNotFoundError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallWrongData() {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        fakeNetworkManager.useCase = .wrongData
        categoriesViewModel = CategoriesViewModel(networkManager: fakeNetworkManager)
        
        //When
        categoriesViewModel.fetchAllCategories()
        let expectation = XCTestExpectation(description: "Fetching Categories list with wrong response data")
        let waitDuration = 1.0

        //Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.categoriesViewModel)
            XCTAssertEqual(self.categoriesViewModel.categoriesListFiltered.count, 0)
            XCTAssertNotNil(self.categoriesViewModel.customError)
            XCTAssertEqual(self.categoriesViewModel.customError, .parsingError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallTimeout() {
            //Given
            let fakeNetworkManager = FakeNetworkManager()
            fakeNetworkManager.useCase = .timeout
            categoriesViewModel = CategoriesViewModel(networkManager: fakeNetworkManager)
            
            //When
            categoriesViewModel.fetchAllCategories()
            let expectation = XCTestExpectation(description: "Fetching Categories list with timeOut Error")
            let waitDuration = 1.0

            //Then
            DispatchQueue.main.async {
                XCTAssertNotNil(self.categoriesViewModel)
                XCTAssertEqual(self.categoriesViewModel.categoriesListFiltered.count, 0)
                XCTAssertNotNil(self.categoriesViewModel.customError)
                XCTAssertEqual(self.categoriesViewModel.customError, .timeOutError)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: waitDuration)
        }
        
        

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
