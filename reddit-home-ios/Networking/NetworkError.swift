//
//  NetworkError.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case statusCode(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:       return "Invalid URL."
        case .noData:           return "Empty response."
        case .decodingFailed:   return "Decoding failed."
        case .statusCode(let c):return "Error HTTP: \(c)"
        }
    }
}
