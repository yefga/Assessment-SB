//
//  NetworkRouter.swift
//  SBTCryptoApp
//
//  Created by Yefga on 07/07/21.
//

import Alamofire

public enum NetworkRouter: URLRequestConvertible {
    
    case topList(limit: Int, page: Int)
    case latestNews(categories: String)
    
    static let baseURLString = "https://min-api.cryptocompare.com/data/"
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .topList:
            return "top/totaltoptiervolfull"
        case .latestNews:
            return "v2/news/"
        }
    }
    
    // MARK: URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        
        let url = try NetworkRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
            case .topList(let limit, let page):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: ["limit":limit, "page": page, "tsym": currencyRequest])
            case .latestNews(let categories):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: ["categories":categories, "lang": languageRequest])
        }
     
        return urlRequest
    }
}


