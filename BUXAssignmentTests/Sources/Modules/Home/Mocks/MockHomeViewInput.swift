//
//  MockHomeViewController.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import UIKit

class MockHomeViewInput: HomeViewInput {
    var output: HomeViewOutput!
    
    private (set) var lastErrorMessage: String?
    
    
    // MARK: - HomeViewInput
    
    func showError(errorMessage: String) {
        lastErrorMessage = errorMessage
    }
}
