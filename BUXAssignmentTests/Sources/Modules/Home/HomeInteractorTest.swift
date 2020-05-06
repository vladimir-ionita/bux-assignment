//
//  HomeInteractorTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class HomeInteractorTest: XCTestCase {
    var interactor: HomeInteractor!
    var mockInteractorOutput: MockHomeInteractorOutput!
    var mockProductService: MockProductService!
    
    override func setUp() {
        super.setUp()
        
        mockProductService = MockProductService()
        interactor = HomeInteractor(productService: mockProductService)
        
        mockInteractorOutput = MockHomeInteractorOutput()
        interactor.output = mockInteractorOutput
    }
    
    func testThatWhenInteractorReceivesARequestToFetchAProductItRequestsProductService() {
        interactor.fetchProduct(identifier: "26608")
        XCTAssertTrue(mockProductService.fetchProductCalled)
    }
    
    func testThatWhenProductServiceReturnsAProductInteractorReturnsTheProductToInteractorOutput() {
        mockProductService.nextProduct = Stubs.productStub()
        interactor.fetchProduct(identifier: "26608")
        XCTAssertTrue(mockInteractorOutput.productFetchSucceedCalled)
    }
    
    func testThatWhenProductServiceReturnsAnErrorInteractorReturnsTheErrorToInteractorOutput() {
        mockProductService.nextError = HTTPClientError.NetworkError
        interactor.fetchProduct(identifier: "26608")
        XCTAssertTrue(mockInteractorOutput.productFetchFailedCalled)
    }
}
