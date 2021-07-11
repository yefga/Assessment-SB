//
//  TopListInteractorTests.swift
//  SBTCryptoAppTests
//
//  Created by Yefga on 10/07/21.
//

import XCTest
@testable import SBTCryptoApp

class TopListsInteractorTests: XCTestCase {
    
    var sut: TopListsInteractor!
    let output = MockTopListsPresenter()

    override func setUp() {
        super.setUp()
        self.sut = TopListsInteractor()
        self.sut.presenter = output

    }
    
    func testSuccessTopListsInteractor() {
        let expectation = expectation(description: "Items Not Empty, Because Input Parameters is fulfilled ✅")
        output.expectation = expectation
        sut.fetchTopLists(limit: 10, page: 1)
        wait(for: [expectation], timeout: 60)
    }
    
    func testFailedTopListsInteractorMin() {
        let expectation = expectation(description: "Item is Empty, Because limit is less min value 🚫")
        output.expectation = expectation
        sut.fetchTopLists(limit: 5, page: 1)
        wait(for: [expectation], timeout: 60)
    }
    
    func testFailedTopListsInteractorMax() {
        let expectation = expectation(description: "Item is Empty, Because limit is larger max value 🚫")
        output.expectation = expectation
        sut.fetchTopLists(limit: 10000, page: 1)
        wait(for: [expectation], timeout: 60)
    }
 
    func testFailedFetchTopLists() {
        let expectation = expectation(description: "Failed to connect to server")
        output.expectation = expectation
        sut.fetchTopLists(limit: 10, page: 1)
        wait(for: [expectation], timeout: 60)
    }
    

}

class MockTopListsPresenter: TopListsInteractorToPresenterProtocol {
    
    var expectation: XCTestExpectation?
    
    func getItems(items: [CryptoCurrency]?, message: String?) {
        if let items = items {
            XCTAssertEqual(items.count, 10)
            XCTAssertTrue(message == "Success")
            expectation?.fulfill()
        } else {
            XCTFail("items is nil")
            expectation?.fulfill()
        }
        
    }
    
    func gotFailed(_ data: Data?, _ error: Error) {
        if let data = data {
            XCTAssertFalse(data.isEmpty)
        } else {
            XCTAssertTrue(data == nil)
        }
        
        XCTAssertFalse(error.localizedDescription.isEmpty)
        
        expectation?.fulfill()
    }
}
