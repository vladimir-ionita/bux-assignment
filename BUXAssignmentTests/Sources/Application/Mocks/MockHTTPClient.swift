//
//  MocHTTPClient.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import Foundation

class MockHTTPClient: HTTPClientProtocol {
    private (set) var lastRequest: URLRequest?
    var nextData: Data?
    var nextError: HTTPClientError?
    
    func get(request: URLRequest, completion: HTTPResult?) {
        lastRequest = request
        
        completion?(nextData, nextError)
    }
}
