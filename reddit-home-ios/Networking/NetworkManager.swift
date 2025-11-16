//
//  NetworkManager.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://www.reddit.com/.json"
    
    // MARK: - Fetch Posts
    func fetchHomePosts(completion: @escaping (Result<[PostModel], Error>) -> Void) {
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.noData)) }
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(RedditResponse.self, from: data)
                
                let posts = decoded.data.children.compactMap { child -> PostModel? in
                    let p = child.data
                    
                    let imageURL = extractImageURL(from: p)
                    
                    return PostModel(
                        id: p.id,
                        title: p.title,
                        upvotes: p.score,
                        comments: p.num_comments,
                        body: p.selftext ?? "",
                        imageURL: imageURL
                    )
                }
                
                DispatchQueue.main.async { completion(.success(posts)) }
                
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        
        task.resume()
    }
}


// MARK: - Extract Image URL Helper
private func extractImageURL(from data: RedditPostData) -> URL? {
    
    if let preview = data.preview,
       let rawURL = preview.images.first?.source.url {
        return sanitizeURL(rawURL)
    }
    
    if let thumb = data.thumbnail,
       thumb.hasPrefix("http") {
        return sanitizeURL(thumb)
    }
    
    return nil
}


private func sanitizeURL(_ urlString: String) -> URL? {
    let cleaned = urlString.replacingOccurrences(of: "&amp;", with: "&")
    return URL(string: cleaned)
}


// MARK: - Custom Errors
enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "URL inválida."
        case .noData: return "La respuesta viene vacía."
        case .decodingFailed: return "No se pudo decodificar el JSON."
        }
    }
}
