//
//  MapResponse.swift
//  SBTCryptoApp
//
//  Created by Yefga on 10/07/21.
//

import ObjectMapper

public class MapArray<T: Mappable>: Mappable {
    public var message = ""
    public var response = ""
    public var data: [T]?
    
    //Impl. of Mappable protocol
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        message     <- map["Message"]
        response <- map["Response"]
        data           <- map["Data"]
    }
}
