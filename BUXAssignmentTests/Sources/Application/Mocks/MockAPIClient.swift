//
//  MockAPIClient.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import Foundation

class MockAPIClient: APIClientProtocol {
    private (set) var lastURL: URL?
    var nextJsonDictionary: JSONDictionary?
    var nextError: APIClientError?
    
    func get(url: URL, headers: [String : String], completion: @escaping APIClientResult) {
        self.lastURL = url
        
        completion(nextJsonDictionary, nextError)
    }
}
