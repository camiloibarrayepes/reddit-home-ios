//
//  HomeViewModel.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

class HomeViewModel {
    
    private(set) var posts: [PostModel] = []
    
    enum State {
        case idle
        case loading
        case loaded
        case error(String)
    }
    
    private(set) var state: State = .idle {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.onStateChange?(self?.state ?? .idle)
            }
        }
    }
    
    var onStateChange: ((State) -> Void)?
    var onPostsUpdated: (() -> Void)?
    
    func fetchPosts() {
        state = .loading
        
        NetworkManager.shared.fetchHomePosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.posts = posts
                self.state = .loaded
                self.onPostsUpdated?()
                
            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
}

#if DEBUG
extension HomeViewModel {
    func setStateForTests(_ state: State) {
        self.state = state
        self.onStateChange?(state)
    }
}
#endif
