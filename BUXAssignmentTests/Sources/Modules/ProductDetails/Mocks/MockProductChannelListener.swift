//
//  MockProductChannelObserver.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import Foundation

class MockProductChannelListener: ProductChannelListenerInput {
    private (set) var subscribeMethodCalled = false
    private (set) var unsubscribeMethodCalled = false
    
    func subscribeToChannel(productIdentifier: String) {
        subscribeMethodCalled = true
    }
    
    func unsubscribeFromChannel(productIdentifier: String) {
        unsubscribeMethodCalled = true
    }
}
