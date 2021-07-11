//
//  MapArrayTests.swift
//  SBTCryptoAppTests
//
//  Created by Yefga on 10/07/21.
//

import XCTest
import ObjectMapper
@testable import SBTCryptoApp

class MapArrayTests: XCTestCase {
    
    func testMapArrayModel() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "TopLists", ofType: "json") else {
            fatalError("TopLists.json gak bisa dibuka")
        }
        
        guard let JSONString = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Konversi ke string")
        }
        
        let response = MapArray<CryptoCurrency>(JSONString: JSONString)

        XCTAssertEqual(response?.message, "Success")
        XCTAssertEqual(response?.data, [])
        XCTAssertGreaterThan(1, response?.data?.count ?? 0)
        XCTAssertGreaterThan(response?.data?.count ?? 0, 1)
    }
    
}

