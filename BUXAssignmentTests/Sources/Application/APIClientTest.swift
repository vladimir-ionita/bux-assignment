//
//  APIClientTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import XCTest

class APIClientTest: XCTestCase {
    func testAPIClientRequestsHttpClient() {
        let urlString = "http://localhost:8080/core/16/products/26608"
        let headerField = HTTPHeaders.authorization
        let headerValue = HTTPRequestHeadersDefaults.authorizationToken
        
        let httpClient = MockHTTPClient()
        let apiClient = APIClient(httpClient: httpClient)
        apiClient.get(url: URL(string: urlString)!, headers: [headerField : headerValue]) { (_, _) in }
        
        XCTAssertTrue(httpClient.lastRequest?.url?.absoluteString == urlString
                && httpClient.lastRequest?.value(forHTTPHeaderField: headerField) == headerValue)
    }
    
    func testAPIClientReturnSerializedJson() {
        let httpClient = MockHTTPClient()
        httpClient.nextData = try? JSONSerialization.data(withJSONObject: Stubs.productJson(), options: [])
        
        let urLString = "http://localhost:8080/core/16/products/26608"
        let apiClient = APIClient(httpClient: httpClient)
        var json: JSONDictionary?
        apiClient.get(url: URL(string: urLString)!, headers: [ : ]) { (jsonDictionary, _) in
            json = jsonDictionary
        }
        
        let expectedJson = Stubs.productJson()
        XCTAssertEqual(expectedJson["securityId"] as? String, json?["securityId"] as? String)
    }
    
    func testAPIClientReturnsNetworkError() {
        let httpClient = MockHTTPClient()
        httpClient.nextError = HTTPClientError.NetworkError
        
        let urLString = "http://localhost:8080/core/16/products/26608"
        let apiClient = APIClient(httpClient: httpClient)
        var error: Error?
        apiClient.get(url: URL(string: urLString)!, headers: [ : ]) { (_, anError) in
            error = anError
        }
        
        XCTAssertNotNil(error)
    }
    
    func testAPIClientReturnsSerializationError() {
        let httpClient = MockHTTPClient()
        httpClient.nextData = "invalid json".data(using: .utf8)
        
        let urLString = "http://localhost:8080/core/16/products/26608"
        let apiClient = APIClient(httpClient: httpClient)
        var error: Error?
        apiClient.get(url: URL(string: urLString)!, headers: [ : ]) { (_, anError) in
            error = anError
        }
        
        XCTAssertNotNil(error)
    }
}
