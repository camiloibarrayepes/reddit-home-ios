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
}
