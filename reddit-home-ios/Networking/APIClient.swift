//
//  APIClient.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

class APIClient {

    static let shared = APIClient()
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ route: APIRouter, completion: @escaping (Result<T, Error>) -> Void) {

        let url = route.url

        let task = session.dataTask(with: url) { data, response, error in

            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            if let http = response as? HTTPURLResponse,
               !(200...299).contains(http.statusCode) {
                DispatchQueue.main.async { completion(.failure(NetworkError.statusCode(http.statusCode))) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NetworkError.noData)) }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(NetworkError.decodingFailed)) }
            }
        }

        task.resume()
    }
}
