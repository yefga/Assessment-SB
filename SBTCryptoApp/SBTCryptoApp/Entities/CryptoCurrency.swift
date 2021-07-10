//
//  CryptoCurrency.swift
//  SBTCryptoApp
//
//  Created by Yefga on 09/07/21.
//


import ObjectMapper

class CryptoCurrency: Mappable {
    var id: String?
    var guid: String?
    var publishedOn: Int?
    var imageurl: String?
    var title: String?
    var url: String?
    var source, body, tags, categories: String?
    var upvotes, downvotes: String?
    var lang: Lang?
    var sourceInfo: SourceInfo?
    
    required init?(map: Map) {

    }
        
    func mapping(map: Map) {
        id <- map["id"]
        guid <- map["guid"]
        publishedOn <- map ["published_on"]
        imageurl <- map ["imageurl"]
        title <- map ["title"]
        url <- map ["url"]
        source <- map ["source"]
        body <- map ["body"]
        tags <- map ["tags"]
        categories <- map ["categories"]
        upvotes <- map ["upvotes"]
        downvotes <- map ["downvotes"]
        lang <- map ["lang"]
        sourceInfo <- map ["source_info"]
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
