//
//  PostModel.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

struct PostModel {
    let id: String
    let title: String
    let upvotes: Int
    let comments: Int
    let body: String
    let imageURL: URL?
    let imageWidth: Int?
    let imageHeight: Int?
}

extension PostModel {
    init(from redditPost: RedditPostData) {
        self.id = redditPost.id
        self.title = redditPost.title
        self.upvotes = redditPost.score ?? 0
        self.comments = redditPost.num_comments ?? 0
        self.body = redditPost.selftext ?? ""
        
        if let preview = redditPost.preview,
           let first = preview.images.first {

            self.imageURL = URLHelper.sanitize(first.source.url)
            self.imageWidth = first.source.width
            self.imageHeight = first.source.height

        } else {
            self.imageURL = nil
            self.imageWidth = nil
            self.imageHeight = nil
        }
    }
}

