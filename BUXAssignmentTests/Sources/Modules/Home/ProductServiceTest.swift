//
//  ProductServiceTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class ProductServiceTest: XCTestCase {
    func testThatProductServiceRequestsAPIClientWithAnURL() {
        let apiClient = MockAPIClient()
        let productService = ProductService(apiClient: apiClient)
        productService.fetchProduct(identifier: "26608") { (_, _) in }
        
        XCTAssertNotNil(apiClient.lastURL)
    }
    
    func testThatProductServiceReturnsProduct() {
        let apiClient = MockAPIClient()
        apiClient.nextJsonDictionary = Stubs.productJson()
        
        let productService = ProductService(apiClient: apiClient)
        var product: Product?
        productService.fetchProduct(identifier: "26608") { (theProduct, _) in
            product = theProduct
        }
        
        XCTAssertTrue(product?.identifier == "26608")
    }
    
    func testThatProductServiceReturnsError() {
        let apiClient = MockAPIClient()
        apiClient.nextError = APIClientError.SerializerError
        
        let productService = ProductService(apiClient: apiClient)
        var error: Error?
        productService.fetchProduct(identifier: "26608") { (_, theError) in
            error = theError
        }
        
        XCTAssertNotNil(error)
    }
}
