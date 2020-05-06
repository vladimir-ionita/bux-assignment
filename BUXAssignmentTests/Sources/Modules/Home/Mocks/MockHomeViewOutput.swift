//
//  HomePresenterTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

class MockHomeViewOutput: HomeViewOutput {
    var view: HomeViewInput!
    
    var invalidIdentifier = false
    private (set) var checkProductMethodCalled = false
    
    // MARK: - HomeViewOutput
    func checkProduct(productIdentifier: String) {
        checkProductMethodCalled = true
        
        if invalidIdentifier {
            view.showError(errorMessage: "Error Message")
        }
    }
}
