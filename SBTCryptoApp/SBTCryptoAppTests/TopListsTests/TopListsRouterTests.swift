//
//  TopListsRouterTests.swift
//  SBTCryptoAppTests
//
//  Created by Yefga on 10/07/21.
//

import XCTest
@testable import SBTCryptoApp

class TopListsRouterTests: XCTestCase {
    
    var router: TopListsRouter!
    
    override func setUp() {
        super.setUp()
        self.router = TopListsRouter()
    }
    
    func testTopListsRouter() {
        let vc = router.createModule()
        XCTAssertTrue(vc.topmostViewController() is TopListsViewController)
    }
    
}


