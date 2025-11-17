//
//  RedditResponse.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

struct RedditResponse: Codable {
    let data: RedditListingData
}

struct RedditListingData: Codable {
    let children: [RedditChild]
}

struct RedditChild: Codable {
    let data: RedditPostData
}

struct RedditPostData: Codable {
    let id: String
    let title: String
    let score: Int?
    let num_comments: Int?
    let selftext: String?
    let thumbnail: String?
    let preview: RedditPreview?
}

struct RedditPreview: Codable {
    let images: [RedditImage]
}

struct RedditImage: Codable {
    let source: RedditImageSource
}

struct RedditImageSource: Codable {
    let url: String
}
