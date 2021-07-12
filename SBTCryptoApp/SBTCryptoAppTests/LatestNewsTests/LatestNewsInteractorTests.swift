//
//  LatestNewsInteractorTests.swift
//  SBTCryptoAppTests
//
//  Created by Yefga on 12/07/21.
//

import XCTest
@testable import SBTCryptoApp

class LatestNewsInteractorTests: XCTestCase {
    
    var sut: LatestNewsInteractor!
    let output = MockLatestNewsPresenter()
    
    override func setUp() {
        super.setUp()
        self.sut = LatestNewsInteractor()
        self.sut.presenter = output
        
    }
    
    func testSuccessInitialLatestNewsInteractor() {
        let initial = expectation(description: "Loaded First Time ✅")
        output.expectation = initial
        
        sut.fetchNews(by: "BTC", type: .initial)
        wait(for: [initial], timeout: 30)
    }
    
}

class MockLatestNewsPresenter: LatestNewsInteractorToPresenterProtocol {
    
    var expectation: XCTestExpectation?
    var storedItems: [CryptoCurrency] = []
    
    func getItems(items: [News]?, type: LoadingType) {
        if let items = items {
            XCTAssertGreaterThan(items.count, 1)
            expectation?.fulfill()
        }
    }
    
    func gotFailed(_ data: Data?, error: Error) {
        if let data = data {
            XCTAssertFalse(data.isEmpty)
        } else {
            XCTAssertTrue(data == nil)
        }
        
        XCTAssertFalse(error.localizedDescription.isEmpty)
        
        expectation?.fulfill()
    }
}
