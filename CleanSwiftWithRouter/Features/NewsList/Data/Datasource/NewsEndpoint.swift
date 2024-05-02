//
//  NewsDataSource.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Foundation

class NewsEndpoint: BaseEndpoint {
    var type: RequestType {
        return .GET
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var headers: [String : Any]? {
        return nil
    }
    
     var path: String? {
        return "https://newsapi.org/v2/everything?apiKey=6b42d1b4f6fd44b1bafcd16742904f45&q=apple&pageSize=2"
    }
}
