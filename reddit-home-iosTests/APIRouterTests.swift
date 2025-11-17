//
//  APIRouterTests.swift
//  reddit-home-iosTests
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit
import Testing
import XCTest
@testable import reddit_home_ios

final class APIRouterTests: XCTestCase {

    func testHomeURL() {
        let url = APIRouter.home.url.absoluteString
        XCTAssertEqual(url, "https://www.reddit.com/.json")
    }

}
