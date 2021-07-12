//
//  News.swift
//  SBTCryptoApp
//
//  Created by Yefga on 11/07/21.
//

import ObjectMapper

public class News: Mappable {
    
    var id: String?
    var title: String?
    var body, categories, url: String?

    public required init?(map: Map) {

    }
        
    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        categories <- map["categories"]
        url <- map["url"]
    }
    
}

extension News: Equatable {
    public static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id
    }
}
