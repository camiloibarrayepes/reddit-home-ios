//
//  ImageLoader.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit

final class ImageLoader {

    static let shared = ImageLoader()
    private init() {}

    private let cache = NSCache<NSURL, UIImage>()
    private var runningRequests = [UUID: URLSessionDataTask]()


    /// Loading an Image from URL with memory Cache
    func load(url: URL, completion: @escaping (UIImage?) -> Void) -> UUID {

        // if the image already exists in cache -> return it
        if let cached = cache.object(forKey: url as NSURL) {
            completion(cached)
            return UUID()
        }

        // create an id for the request
        let uuid = UUID()

        // download the image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            defer { self?.runningRequests.removeValue(forKey: uuid) }

            // Error or no data → return nil
            guard let data = data,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            // save in caché
            self?.cache.setObject(image, forKey: url as NSURL)

            // Return on Main thread
            DispatchQueue.main.async {
                completion(image)
            }
        }

        task.resume()

        runningRequests[uuid] = task
        return uuid
    }


    /// Cancel request
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
