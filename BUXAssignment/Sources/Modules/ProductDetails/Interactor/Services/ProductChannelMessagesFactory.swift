//
//  EventMessageFactory.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class ProductChannelMessagesFactory {
    static func subscribeMessage(identifier: String) -> Data {
        let messageJson = [
            "subscribeTo" : [
                "trading.product.\(identifier)"
            ]
        ]
        
        return try! JSONSerialization.data(withJSONObject: messageJson, options: [])
    }
    
    static func unsubscribeMessage(identifier: String) -> Data {
        let messageJson = [
            "unsubscribeFrom" : [
                "trading.product.\(identifier)"
            ]
        ]
        
        return try! JSONSerialization.data(withJSONObject: messageJson, options: [])
    }
}
