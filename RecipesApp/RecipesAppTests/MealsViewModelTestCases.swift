//
//  MealsViewModelTestCases.swift
//  RecipesAppTests
//
//  Created by Andres D. Paladines on 8/22/23.
//

import XCTest
@testable import RecipesApp

final class MealsViewModelTestCases: XCTestCase {

    var mealsViewModel: MealsViewModel!
    var categoriesViewModel: CategoriesViewModel!
    
    override func setUpWithError() throws {
        
        categoriesViewModel = CategoriesViewModel(networkManager: FakeNetworkManager())
    }

    override func tearDownWithError() throws {
       
    }

    func testApiCallOk() {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        fakeNetworkManager.useCase = .fullList
        mealsViewModel = MealsViewModel(networkManager: fakeNetworkManager)
        
        //When
        mealsViewModel.fetchPreviewMealsFromAPI("Beef")
        let expectation = XCTestExpectation(description: "Fetching Meals list with correct data")
        let waitDuration = 0.1

        //Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.mealsViewModel)
            XCTAssertEqual(self.mealsViewModel.prefOneMealPreviewsList.count, 4)
            XCTAssertNil(self.mealsViewModel.customError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallEmptyList() {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        fakeNetworkManager.useCase = .emptyList
        mealsViewModel = MealsViewModel(networkManager: fakeNetworkManager)
        
        //When
        mealsViewModel.fetchPreviewMealsFromAPI("Beef")
        let expectation = XCTestExpectation(description: "Fetching Meals with empty list")
        let waitDuration = 1.0

        //Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.mealsViewModel)
            XCTAssertEqual(self.mealsViewModel.prefOneMealPreviewsList.count, 0)
            XCTAssertNotNil(self.mealsViewModel.customError)
            XCTAssertEqual(self.mealsViewModel.customError, .dataNotFoundError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallWrongData() {
        //Given
        let fakeNetworkManager = FakeNetworkManager()
        fakeNetworkManager.useCase = .wrongData
        mealsViewModel = MealsViewModel(networkManager: fakeNetworkManager)
        
        //When
        mealsViewModel.fetchPreviewMealsFromAPI("Beef")
        let expectation = XCTestExpectation(description: "Fetching Meals list with wrong response data")
        let waitDuration = 1.0

        //Then
        DispatchQueue.main.async {
            XCTAssertNotNil(self.mealsViewModel)
            XCTAssertEqual(self.mealsViewModel.prefOneMealPreviewsList.count, 0)
            XCTAssertNotNil(self.mealsViewModel.customError)
            XCTAssertEqual(self.mealsViewModel.customError, .parsingError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: waitDuration)
    }
    
    func testApiCallTimeout() {
            //Given
            let fakeNetworkManager = FakeNetworkManager()
            fakeNetworkManager.useCase = .timeout
            mealsViewModel = MealsViewModel(networkManager: fakeNetworkManager)
            
            //When
            mealsViewModel.fetchPreviewMealsFromAPI("Beef")
            let expectation = XCTestExpectation(description: "Fetching Meals list with timeOut Error")
            let waitDuration = 1.0

            //Then
            DispatchQueue.main.async {
                XCTAssertNotNil(self.mealsViewModel)
                XCTAssertEqual(self.mealsViewModel.prefOneMealPreviewsList.count, 0)
                XCTAssertNotNil(self.mealsViewModel.customError)
                XCTAssertEqual(self.mealsViewModel.customError, .timeOutError)
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
