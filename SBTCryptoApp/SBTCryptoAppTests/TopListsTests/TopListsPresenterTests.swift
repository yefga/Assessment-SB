//
//  TopListsPresenterTests.swift
//  SBTCryptoAppTests
//
//  Created by Yefga on 10/07/21.
//

import XCTest
import Alamofire
import ObjectMapper
@testable import SBTCryptoApp

class TopListsPresenterTests: XCTestCase {
    
    var sut: TopListsPresenter!
    var input = MockTopListsInteractor()
    
    override func setUp() {
        super.setUp()
        self.sut = TopListsPresenter()
        
        self.sut.interactor = input
        self.input.presenter = sut
    }
    
    func testSuccessItemsIsEmpty() {
        let items: [CryptoCurrency] = []
        self.sut.getItems(items: items, message: "", type: .initial)
        XCTAssertEqual(sut.totalItems, 0)
    }
    
    func testSuccessWithMockedItemsNotEmpty() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "TopLists", ofType: "json") else {
            fatalError("TopLists.json gak bisa dibuka")
        }
        
        guard let JSONString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Konversi ke string")
        }
        
        let response = MapArray<CryptoCurrency>(JSONString: JSONString)
        
        self.sut.getItems(items: response?.data, message: "Success", type: .initial)
        XCTAssertGreaterThan(sut.totalItems, 1)
    }
    
    func testSuccessInitialFetch() {
        let initial = expectation(description: "Initial Loaded")
        input.expectation = initial
        input.fetchTopLists(limit: 10, page: 1, type: .initial)
        wait(for: [initial], timeout: 30.0)
        XCTAssertEqual(sut.totalItems, 10)
    }
    
    func testSuccessLoadMoreFetch() {
        self.testSuccessInitialFetch()
        
        let more = expectation(description: "More Loaded")
        input.expectation = more
        input.fetchTopLists(limit: 10, page: 2, type: .more)
        wait(for: [more], timeout: 30.0)
        
        XCTAssertGreaterThan(sut.totalItems, 10)
        XCTAssertNotEqual(sut.currentPage, 1)

    }
    
    func testSuccessRefreshFetch() {
        self.testSuccessLoadMoreFetch()
        
        let refresh = expectation(description: "Refresh Successfully")
        input.expectation = refresh
        input.fetchTopLists(limit: 10, page: 1, type: .refresh)
        wait(for: [refresh], timeout: 30.0)
        
        XCTAssertEqual(sut.totalItems, 10)
        XCTAssertEqual(sut.listItems.count, sut.totalItems)
        XCTAssertEqual(sut.currentPage, 1)
        
    }
    
    func testFailedWithMinLimit() {
        let expectation = expectation(description: "The items is empty")
        input.expectation = expectation
        input.fetchTopLists(limit: 5, page: 1, type: .initial)
        wait(for: [expectation], timeout: 30.0)
        
        XCTAssertNotEqual(sut.totalItems, 10)
        XCTAssertEqual(sut.totalItems, 0)
        
    }
    
}


class MockTopListsInteractor: TopListsPresenterToInteractorProtocol {
    
    var presenter: TopListsInteractorToPresenterProtocol?
    
    var expectation: XCTestExpectation?
    
    func fetchTopLists(limit: Int, page: Int, type: LoadingType) {
        Alamofire
            .Session
            .default
            .request(NetworkRouter.topList(limit: limit, page: page))
            .validate()
            .responseObject { (response: AFDataResponse<MapArray<CryptoCurrency>>) in
                switch response.result {
                case .success(let result):
                    self.presenter?.getItems(items: result.data, message: result.message, type: type)
                    self.expectation?.fulfill()
                case .failure(let error):
                    self.presenter?.gotFailed(response.data, error)
                    self.expectation?.fulfill()
                }
            }
    }
    
    
}
