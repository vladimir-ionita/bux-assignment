//
//  MockProductDetailsModuleInput.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import Foundation

class MockProductDetailsModuleInput: ProductDetailsModuleInput {
    private (set) var configureModuleCalled = false
    
    func configureModule(product: Product) {
        configureModuleCalled = true
    }
}
