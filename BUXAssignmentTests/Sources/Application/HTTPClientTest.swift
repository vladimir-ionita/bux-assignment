//
//  HTTPClientTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class HTTPClientTest: XCTestCase {
    private var client: HTTPClient!
    private let session = MockURLSession()
    private let request: URLRequest = {
        let url = URL(string: "http://localhost:8080/")
        return URLRequest(url: url!)
    }()
    
    override func setUp() {
        super.setUp()
        client = HTTPClient(session: session)
    }
    
    func testThatClientAddsRequestToTheSession() {
        client.get(request: request, completion: nil)
        
        XCTAssert(session.lastRequest == request)
    }
    
    func testThatClientStartsTheTask() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        client.get(request: request, completion: nil)
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testThatClientReturnsErrorIfThereIsAnyError() {
        session.nextError = HTTPClientError.NetworkError
        
        let testExpectation = expectation(description: "Client should return an error")
        client.get(request: request) { (_, anError) in
            XCTAssertNotNil(anError)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testThatClientReturnsErrorInCaseTheStatusCodeIsLessThan200() {
        session.nextResponse = HTTPURLResponse(url: request.url!,
                                               statusCode: 199,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let testExpectation = expectation(description: "Client should return an error")
        client.get(request: request) { (_, anError) in
            XCTAssertNotNil(anError)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testThatClientReturnsErrorInCaseTheStatusCodeIsGreaterThan299() {
        session.nextResponse = HTTPURLResponse(url: request.url!,
                                               statusCode: 300,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let testExpectation = expectation(description: "Client should return an error")
        client.get(request: request) { (_, anError) in
            XCTAssertNotNil(anError)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testThatClientReturnsErrorUnauthorizedInCaseTheStatusCodeIs401() {
        session.nextResponse = HTTPURLResponse(url: request.url!,
                                               statusCode: 401,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let testExpectation = expectation(description: "Client should return an unauthorized error")
        client.get(request: request) { (_, anError) in
            XCTAssertTrue(anError == HTTPClientError.Unauthorized)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testThatClientReturnsErrorForbiddenInCaseTheStatusCodeIs403() {
        session.nextResponse = HTTPURLResponse(url: request.url!,
                                               statusCode: 403,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let testExpectation = expectation(description: "Client should return a forbidden error")
        client.get(request: request) { (_, anError) in
            XCTAssertTrue(anError == HTTPClientError.Forbidden)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testThatClientReturnsErrorNotFoundInCaseTheStatusCodeIs404() {
        session.nextResponse = HTTPURLResponse(url: request.url!,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let testExpectation = expectation(description: "Client should return a resource not found error")
        client.get(request: request) { (_, anError) in
            XCTAssertTrue(anError == HTTPClientError.ResourceNotFound)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
    
    func testThatClientReturnsDataIfTheRequestIsSuccessful() {
        let expectedData = "{test:test}".data(using: .utf8)
        session.nextData = expectedData
        session.nextResponse = HTTPURLResponse(url: request.url!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        
        let testExpectation = expectation(description: "Client should return data")
        client.get(request: request) { (data, _) in
            XCTAssertEqual(data, expectedData)
            testExpectation.fulfill()
        }
        
        wait(for: [testExpectation], timeout: 0.1)
    }
}
