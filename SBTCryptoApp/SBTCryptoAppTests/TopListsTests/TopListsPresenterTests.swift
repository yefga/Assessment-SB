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
        self.sut.getItems(items: items, message: "")
        XCTAssertEqual(sut.totalItems, 0)
        XCTAssertEqual(sut.errorMessage, "")
    }
    
    func testSuccessWithMockedItemsNotEmpty() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "TopLists", ofType: "json") else {
            fatalError("TopLists.json gak bisa dibuka")
        }
        
        guard let JSONString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Konversi ke string")
        }
        
        let response = MapArray<CryptoCurrency>(JSONString: JSONString)
        
        self.sut.getItems(items: response?.data, message: "Success")
        XCTAssertTrue(self.sut.errorMessage.isEmpty)
        XCTAssertGreaterThan(sut.totalItems, 1)
    }
    
    func testSuccessNonEmptyItemsFromInteractor() {
        let expectation = expectation(description: "The items is not empty")
        input.expectation = expectation
        input.fetchTopLists(limit: 10, page: 1)
        wait(for: [expectation], timeout: 30.0)
        XCTAssertEqual(sut.totalItems, 10)
        XCTAssertTrue(sut.errorMessage.isEmpty)
    }
    
    func testFailedWithLimitMinFromInteractor() {
        let expectation = expectation(description: "The items is empty")
        input.expectation = expectation
        input.fetchTopLists(limit: 5, page: 1)
        wait(for: [expectation], timeout: 30.0)
        XCTAssertNotEqual(sut.totalItems, 10)
        XCTAssertFalse(sut.errorMessage.isEmpty)
    }
    
}


class MockTopListsInteractor: TopListsPresenterToInteractorProtocol {
    
    var presenter: TopListsInteractorToPresenterProtocol?
    
    var expectation: XCTestExpectation?
    
    func fetchTopLists(limit: Int, page: Int) {
        Alamofire
            .Session
            .default
            .request(NetworkRouter.topList(limit: limit, page: page))
            .validate()
            .responseObject { (response: AFDataResponse<MapArray<CryptoCurrency>>) in
                switch response.result {
                case .success(let result):
                    self.presenter?.getItems(items: result.data, message: result.message)
                    self.expectation?.fulfill()
                case .failure(let error):
                    self.presenter?.gotFailed(response.data, error)
                    self.expectation?.fulfill()
                }
            }
    }
    
    
}
