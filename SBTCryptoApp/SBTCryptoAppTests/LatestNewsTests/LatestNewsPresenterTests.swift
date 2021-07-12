//
//  LatestNewsPresenterTests.swift
//  SBTCryptoAppTests
//
//  Created by Yefga on 12/07/21.
//

import XCTest
import Alamofire
import ObjectMapper
@testable import SBTCryptoApp

class LatestNewsPresenterTests: XCTestCase {
    
    var sut: LatestNewsPresenter!
    var input = MockLatestNewsInteractor()
    
    override func setUp() {
        super.setUp()
        self.sut = LatestNewsPresenter()
        
        self.sut.interactor = input
        self.input.presenter = sut
    }
    
    func testSuccessInitialFetch() {
        let initial = expectation(description: "Initial Loaded")
        input.expectation = initial
        input.fetchNews(by: "BTC", type: .initial)
        wait(for: [initial], timeout: 30.0)
        
        XCTAssertEqual(sut.totalItems, 10)
        XCTAssertGreaterThan(sut.listItems.count, 0)
    }
    
    func testSuccessLoadMoreFetch() {
        self.testSuccessInitialFetch()
        
        let more = expectation(description: "More Loaded")
        sut.loadMore()
        more.fulfill()
        
        wait(for: [more], timeout: 20.0)
        XCTAssertGreaterThan(sut.totalItems, 11)

    }
    
}


class MockLatestNewsInteractor: LatestNewsPresenterToInteractorProtocol {
    
    var presenter: LatestNewsInteractorToPresenterProtocol?
    
    var expectation: XCTestExpectation?
    
    func fetchNews(by InitialOfCurrency: String, type: LoadingType) {
     
        Alamofire
            .Session
            .default
            .request(NetworkRouter.latestNews(categories: InitialOfCurrency))
            .validate()
            .responseObject { (response: AFDataResponse<MapArray<News>>) in
                switch response.result {
                case .success(let result):
                    self.presenter?.getItems(items: result.data, type: type)
                    self.expectation?.fulfill()
                case .failure(let error):
                    self.presenter?.gotFailed(response.data, error: error)
                    self.expectation?.fulfill()
                }
            }
    }
    
    
}


