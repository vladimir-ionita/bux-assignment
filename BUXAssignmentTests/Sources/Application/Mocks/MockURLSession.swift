//
//  URLSessionMock.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import Foundation

class MockURLSession: URLSessionProtocol {
    private (set) var lastRequest: URLRequest?
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        self.lastRequest = request
        completionHandler(nextData, nextResponse, nextError)
        
        return nextDataTask

    }
}
