//
//  APIClient.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class APIClient: APIClientProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func get(url: URL, headers: [String : String], completion: @escaping APIClientResult) {
        let request = self.request(url: url, headers: headers)
        httpClient.get(request: request) { (data, error) in
            if let data = data {
                if let jsonDictionary = self.jsonDictionary(data: data) {
                    completion(jsonDictionary, nil)
                } else {
                    completion(nil, APIClientError.SerializerError)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}

// MARK: - Private Methods
private extension APIClient {
    func request(url: URL, headers: [String : String]) -> URLRequest {
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    func jsonDictionary(data: Data) -> JSONDictionary? {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
            return jsonObject as? JSONDictionary
        }
        
        return nil
    }
}
