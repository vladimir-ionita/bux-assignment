//
//  HTTPClient.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class HTTPClient: HTTPClientProtocol {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(request: URLRequest, completion: HTTPResult?) {
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        completion?(data, nil)
                    case 401:
                        completion?(nil, HTTPClientError.Unauthorized)
                    case 403:
                        completion?(nil, HTTPClientError.Forbidden)
                    case 404:
                        completion?(nil, HTTPClientError.ResourceNotFound)
                    default:
                        completion?(nil, HTTPClientError.NetworkError)
                    }
                } else {
                    completion?(nil, HTTPClientError.NetworkError)
                }
            }
        }.resume()
    }
}
