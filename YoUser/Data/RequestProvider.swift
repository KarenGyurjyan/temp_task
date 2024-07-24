//
//  RequestProvider.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation

enum Endpoint: String {
    case users = "https://randomuser.me/api?seed=renderforest"
}

struct RequestProvider: NetworkRequest {
    let results: Int
    let page: Int
    
    init(results: Int, page: Int) {
        self.results = results
        self.page = page
    }
    
    var url: URL? { URL(string: Endpoint.users.rawValue) }
    var queryParameters: [String : String]? {
        ["results": "\(results)", "page": "\(page)"]
    }
}
