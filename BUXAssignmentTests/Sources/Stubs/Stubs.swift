//
//  Stubs.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

class Stubs {
    static func productJson() -> JSONDictionary {
        return [
            "symbol": "FRANCE40",
            "securityId": "26608",
            "displayName": "French Exchange",
            "currentPrice": [
                "currency": "EUR",
                "decimals": 1,
                "amount": "1.2"
            ],
            "closingPrice": [
                "currency": "EUR",
                "decimals": 1,
                "amount": "1.0"
            ]
        ]
    }
    
    static func productStub() -> Product {
        return ProductFactory.productFromJson(productJson())!
    }
}
