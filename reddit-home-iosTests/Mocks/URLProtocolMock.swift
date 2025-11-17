//
//  URLProtocolMock.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import Foundation

class URLProtocolMock: URLProtocol {

    static var testURLs = [URL: Data]()
    static var testResponse: HTTPURLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {

        if let url = request.url {
            if let error = URLProtocolMock.error {
                client?.urlProtocol(self, didFailWithError: error)
                return
            }

            if let data = URLProtocolMock.testURLs[url] {
                if let response = URLProtocolMock.testResponse {
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
                return
            }
        }

        client?.urlProtocol(self, didFailWithError: URLError(.badURL))
    }

    override func stopLoading() {}
}
