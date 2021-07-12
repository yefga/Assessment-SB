//
//  CryptoCurrency.swift
//  SBTCryptoApp
//
//  Created by Yefga on 09/07/21.
//


import ObjectMapper

public class CryptoCurrency: Mappable {
    
    public var coinInfo: CoinInfo?
    public var display: Display?
    
    public required init?(map: Map) {

    }
        
    public func mapping(map: Map) {
        coinInfo <- map["CoinInfo"]
        display <- map["DISPLAY"]
    }
    
}

extension CryptoCurrency: Equatable {
    public static func == (lhs: CryptoCurrency, rhs: CryptoCurrency) -> Bool {
        return lhs.coinInfo?.id == rhs.coinInfo?.id
    }
}

enum Lang: String, Codable {
    case en = "EN"
}

// MARK: - SourceInfo
struct SourceInfo: Codable {
    let name: String
    let lang: Lang
    let img: String
}

public class CoinInfo: Mappable {
    
    public var id, name, fullName: String?
    
    required public init?(map: Map) {

    }
        
    public func mapping(map: Map) {
        id <- map["Id"]
        name <- map["Name"]
        fullName <- map["FullName"]
    }
}


public class Display: Mappable {
    
    public var currency: Currency?
    
    required public init?(map: Map) {

    }
        
    public func mapping(map: Map) {
        currency <- map[currencyRequest]
        
    }
}

public class Currency: Mappable {
    
    public var price: String?
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        price <- map["PRICE"]
    }
}
