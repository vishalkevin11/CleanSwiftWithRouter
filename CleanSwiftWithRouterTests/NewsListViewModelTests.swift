//
//  NewsListViewModelTests.swift
//  CleanSwiftWithRouterTests
//
//  Created by Kevin Vishal on 05/05/24.
//

import XCTest
@testable import CleanSwiftWithRouter

final class NewsListViewModelTests: XCTestCase {
    
    var newsListViewModel: NewsListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        newsListViewModel = NewsListViewModel(newsUsecase: NewsUsecase(newsRespository: NewsListRepoMock()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_NewsListViewModel_FetchNews_Success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let expectation = XCTestExpectation(description: "Fetch news")
        XCTAssertEqual(newsListViewModel.newListResultState, .none)
        newsListViewModel?.fetcNews()
        
        var newsList  = [NewsEntity]()
        
        let result = newsListViewModel.$newListResultState.sink { status in
            switch status {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                expectation.fulfill()
                XCTFail()
            }
        } receiveValue: { resultState in
            switch resultState {
            case .results(let news):
                newsList = news
              
                expectation.fulfill()
            default:
                break
            }
        }

        
        wait(for: [expectation], timeout: 3)
        result.cancel()
        
        XCTAssertEqual(newsList.count, 1)
        XCTAssertEqual(newsList.first?.author, "Kevin")
        XCTAssertEqual(newsList.first?.title, "Title is balcnk")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
