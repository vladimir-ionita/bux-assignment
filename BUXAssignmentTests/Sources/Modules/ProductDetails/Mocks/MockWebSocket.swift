//
//  MockWebSocket.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Starscream

class MockWebSocket: WebSocket {
    private (set) var connectMethodCalled = false
    private (set) var disconnectMethodCalled = false
    private (set) var writeDataMethodCalled = false
    private (set) var lastWrittenData: Data?
    
    override func connect() {
        connectMethodCalled = true
    }
    
    override func disconnect(forceTimeout: TimeInterval?, closeCode: UInt16) {
        disconnectMethodCalled = true
    }
    
    override func write(data: Data, completion: (() -> ())?) {
        lastWrittenData = data
        writeDataMethodCalled = true
    }
}

