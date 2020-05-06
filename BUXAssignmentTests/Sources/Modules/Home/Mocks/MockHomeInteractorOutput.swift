//
//  MockHomeInteractorOutput.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import Foundation

class MockHomeInteractorOutput: HomeInteractorOutput {
    private (set) var productFetchSucceedCalled = false
    private (set) var productFetchFailedCalled = false
    
    // MARK: - HomeInteractorOutput
    func productFetchSucceed(_ product: Product) {
        productFetchSucceedCalled = true
    }
    
    func productFetchFailed(error: Error?) {
        productFetchFailedCalled = true
    }
}
