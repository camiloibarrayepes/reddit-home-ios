//
//  NetworkManagerTests.swift
//  reddit-home-iosTests
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit
import Testing
import XCTest
@testable import reddit_home_ios

final class NetworkManagerTests: XCTestCase {
    
    func testFetchHomePosts_decodesCorrectly() throws {

        let json = """
        {
          "data": {
            "children": [
              {
                "data": {
                  "id": "xyz789",
                  "title": "Mock Post Title",
                  "selftext": "Mock Body",
                  "score": 123,
                  "num_comments": 45,
                  "thumbnail": "https://example.com/thumb.jpg"
                }
              }
            ]
          }
        }
        """.data(using: .utf8)!

        let url = APIRouter.home.url

        // Configurar mock
        URLProtocolMock.testURLs = [url: json]
        URLProtocolMock.testResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)

        let manager = NetworkManager(session: mockSession)

        let expectation = expectation(description: "Fetch posts")

        manager.fetchHomePosts { result in
            switch result {
            case .success(let posts):
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts.first?.id, "xyz789")
                XCTAssertEqual(posts.first?.title, "Mock Post Title")
                XCTAssertEqual(posts.first?.body, "Mock Body")
                XCTAssertEqual(posts.first?.upvotes, 123)
                XCTAssertEqual(posts.first?.comments, 45)

            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }
}
