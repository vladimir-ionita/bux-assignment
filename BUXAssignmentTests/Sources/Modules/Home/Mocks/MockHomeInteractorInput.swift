//
//  MockHomeInteractor.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

class MockHomeInteractorInput: HomeInteractorInput {
    var output: HomeInteractorOutput!
    
    private (set) var getProductCalled = false
    var nextProduct: Product?
    var nextError: Error?
    
    
    // MARK: - HomeInteractorInput
    
    func fetchProduct(identifier: String) {
        getProductCalled = true
        
        if let product = nextProduct {
            output.productFetchSucceed(product)
        }
        
        if let error = nextError {
            output.productFetchFailed(error: error)
        }
    }
}
