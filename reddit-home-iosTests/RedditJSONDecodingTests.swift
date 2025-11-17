//
//  RedditJSONDecodingTests.swift
//  reddit-home-iosTests
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit
import Testing
import XCTest
@testable import reddit_home_ios

final class RedditJSONDecodingTests: XCTestCase {

    func testDecodeSampleRedditJSON() throws {

        let json = """
        {
          "data": {
            "children": [
              {
                "data": {
                  "id": "abc123",
                  "title": "Test Post",
                  "selftext": "",
                  "thumbnail": "https://example.com/thumb.jpg",
                  "preview": {
                    "images": [
                      {
                        "source": {
                          "url": "https://example.com/preview.jpg",
                          "width": 720,
                          "height": 1280
                        }
                      }
                    ]
                  }
                }
              }
            ]
          }
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()

        let decoded = try decoder.decode(RedditResponse.self, from: data)

        XCTAssertEqual(decoded.data.children.count, 1)

        let post = decoded.data.children[0].data
        XCTAssertEqual(post.id, "abc123")
        XCTAssertEqual(post.title, "Test Post")
        XCTAssertEqual(post.thumbnail, "https://example.com/thumb.jpg")
        XCTAssertEqual(
            post.preview?.images.first?.source.url,
            "https://example.com/preview.jpg"
        )
    }
}
