//
//  URLHelper.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 17/11/25.
//

import Foundation

struct URLHelper {

    static func sanitize(_ urlString: String?) -> URL? {
        guard let urlString = urlString else { return nil }

        let cleaned = urlString
            .replacingOccurrences(of: "&amp;", with: "&")

        return URL(string: cleaned)
    }
}
