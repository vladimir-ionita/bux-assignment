//
//  MockProductDetailsInteractorInput.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import UIKit

class MockProductDetailsInteractorInput: ProductDetailsInteractorInput {
    private (set) var subscribeMethodCalled = false
    var subscribeMethodCalledHandler: (() -> Void)?
    
    func subscribeToRealTimeFeedChannel(for productIdentifier: String) {
        subscribeMethodCalled = true
        subscribeMethodCalledHandler?()
    }
    
    func unsubscribeFromRealTimeFeedChannel(for productIdentifier: String) {
        
    }
}
