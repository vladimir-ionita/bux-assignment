//
//  ProductTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 06/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import XCTest

class ProductTest: XCTestCase {
    func testThatProductCanBeInitiated() {
        let currentPrice = Price(currency: "EUR", decimals: 1, amount: 1.0)
        let closingPrice = Price(currency: "EUR", decimals: 1, amount: 1.2)
        let product = Product(identifier: "26608",
                              name: "French Exchange",
                              symbol: "FRANCE40",
                              currentPrice: currentPrice,
                              closingPrice: closingPrice)
        
        XCTAssertTrue(product.identifier == "26608"
            && product.name == "French Exchange"
            && product.symbol == "FRANCE40")
    }

    func testThatProductIsNilForAnEmptyJson() {
        let emptyJson: JSONDictionary = [:]
        let product = ProductFactory.makeProductFromJson(emptyJson)

        XCTAssertNil(product)
    }
    
    func testThatProductIsNilForMalformatedPriceJson() {
        let product = ProductFactory.makeProductFromJson(productJsonWithMalformatedPrice())
        
        XCTAssertNil(product)
    }

    func testThatProductCanBeCreatedFromJson() {
        let product = ProductFactory.makeProductFromJson(Stubs.productJson())
        
        XCTAssertTrue(product?.identifier == "26608" &&
            product?.name == "French Exchange" &&
            product?.symbol == "FRANCE40")
    }

    func testThatRoiIsComputedCorrectly() {
        let product = ProductFactory.makeProductFromJson(Stubs.productJson())!
        
        XCTAssertEqual(product.roi, 20.0, accuracy: 0.0005)
    }

    
    // MARK: - Private Methods
    
    private func productJsonWithMalformatedPrice() -> JSONDictionary {
        return [
            "symbol": "FRANCE40",
            "securityId": "26608",
            "displayName": "French Exchange",
            "currentPrice": [
                "amount": "1.2"
            ],
            "closingPrice": [
                "currency": "EUR",
                "decimals": 1,
                "amount": "1.0"
            ]
        ]
    }
}
