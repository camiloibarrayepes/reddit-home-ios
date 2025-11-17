//
//  HomeViewModelTests.swift
//  reddit-home-iosTests
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit
import Testing
import XCTest
@testable import reddit_home_ios

final class HomeViewModelTests: XCTestCase {

    func testStateTransitions() {
        let viewModel = HomeViewModel()

        var states: [HomeViewModel.State] = []

        viewModel.onStateChange = { state in
            states.append(state)
        }

        viewModel.setStateForTests(.loading)
        viewModel.setStateForTests(.loaded)

        XCTAssertEqual(states.count, 2)
        XCTAssertEqual(states[0], .loading)
        XCTAssertEqual(states[1], .loaded)
    }
}
