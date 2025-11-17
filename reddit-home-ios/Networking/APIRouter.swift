//
//  APIRouter.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

enum APIRouter {

    case home
    
    // This router is intentionally designed to scale.
    // Adding new endpoints (e.g., subreddit feeds, post details, search, pagination)
    // only requires introducing new cases and paths while keeping request logic centralized.

    var path: String {
        switch self {
        case .home:
            return "/.json"
        }
    }

    var method: String {
        return "GET"
    }

    var url: URL {
        return URL(string: APIConstants.baseURL + path)!
    }
}
