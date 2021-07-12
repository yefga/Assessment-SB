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
    
    func testFailedTopListsInteractorMin() {
        let expectation = expectation(description: "Item is Empty, Because limit is less min value 🚫")
        output.expectation = expectation
        
        sut.fetchTopLists(limit: 5, page: 1, type: .initial)
        wait(for: [expectation], timeout: 30)
    }
    
    func testFailedTopListsInteractorMax() {
        let expectation = expectation(description: "Item is Empty, Because limit is larger max value 🚫")
        output.expectation = expectation
        
        sut.fetchTopLists(limit: 10000, page: 1, type: .initial)
        wait(for: [expectation], timeout: 30)
    }
    
    func testFailedFetchTopLists() {
        /// Turn Off Your Connection before testing.
        
//        let expectation = expectation(description: "Failed to connect to server")
//        output.expectation = expectation
//        sut.fetchTopLists(limit: 10, page: 1, type: .initial)
//        wait(for: [expectation], timeout: 60)
    }
    
    func testSuccessInitialTopListsInteractor() {
        let initial = expectation(description: "Loaded First Time ✅")
        output.expectation = initial
        sut.fetchTopLists(limit: 10, page: 1, type: .initial)
        wait(for: [initial], timeout: 30)
    }
    
    func testSuccessLoadMoreWhenFetchTopLists() {
        self.testSuccessInitialTopListsInteractor()
        
        let more = expectation(description: "Loaded More ✅")
        output.expectation = more
        sut.fetchTopLists(limit: 10, page: 2, type: .more)
        
        wait(for: [more], timeout: 30)
    }
    
    func testSuccessRefreshFetchTopLists() {
        
        self.testSuccessLoadMoreWhenFetchTopLists()
        
        let refresh = expectation(description: "Refresh Successfully ✅")
        output.expectation = refresh
        sut.fetchTopLists(limit: 10, page: 1, type: .refresh)
        
        wait(for: [refresh], timeout: 60)
    }
    
}

class MockTopListsPresenter: TopListsInteractorToPresenterProtocol {
    
    var expectation: XCTestExpectation?
    var storedItems: [CryptoCurrency] = []
    
    func getItems(items: [CryptoCurrency]?, message: String?, type: LoadingType) {
        if let items = items {
            
            XCTAssertTrue(message == "Success")
            
            if type != .more {
                self.storedItems.removeAll()
            }
            
            items.forEach { newItem in
                if !self.storedItems.contains(newItem) {
                    self.storedItems.append(newItem)
                }
            }
            
            
            switch type {
                case .initial:
                    XCTAssertEqual(items.count, 10)
                    
                case .more:
                    XCTAssertGreaterThan(self.storedItems.count, items.count)
                    
                case .refresh:
                    XCTAssertEqual(self.storedItems.count, 10)
            }
            
            
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
