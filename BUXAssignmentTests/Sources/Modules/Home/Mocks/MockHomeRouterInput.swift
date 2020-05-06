//
//  MockHomeRouterInput.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import UIKit

class MockHomeRouterInput: HomeRouterInput {
    private (set) var showProductDetailsCalled = false
    /*
     The purpose of this variable is test related.
     It is used in the test that mimics the product details module configuration.
     In the real running, this variable will be stronged referenced by the view controller,
     but in this case we are not using a view controller, so we need to strongly reference it somewhere
     */
    var mockProductDetailsModule: ProductDetailsModuleInput?
    
    // MARK: - HomeRouterInput
    func showProductDetails(sourceController: UIViewController) -> ProductDetailsModuleInput {
        showProductDetailsCalled = true
        mockProductDetailsModule = MockProductDetailsModuleInput()
        
        return mockProductDetailsModule!
    }
}
