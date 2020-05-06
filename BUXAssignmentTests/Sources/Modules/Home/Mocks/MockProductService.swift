//
//  MockProductService.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import Foundation

class MockProductService: ProductServiceProtocol {
    private (set) var fetchProductCalled = false
    var nextProduct: Product?
    var nextError: Error?
    
    // MARK: - ProductServiceProtocol
    func fetchProduct(identifier: String, completion: @escaping ProductServiceResult) {
        fetchProductCalled = true
        
        if let product = nextProduct {
            completion(product, nil)
        } else if let error = nextError {
            completion(nil, error)
        }
    }
}
