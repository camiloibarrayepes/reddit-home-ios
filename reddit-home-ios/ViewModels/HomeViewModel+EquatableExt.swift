//
//  HomeViewModel+EquatableExt.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

extension HomeViewModel.State: Equatable {
    static func ==(lhs: HomeViewModel.State, rhs: HomeViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading),
             (.loaded, .loaded):
            return true

        case (.error, .error):
            return true   // ignores message

        default:
            return false
        }
    }
}
