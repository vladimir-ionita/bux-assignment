//
//  PriceTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 12/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import XCTest

class PriceTest: XCTestCase {
    func testThatPriceCanBeInitiated() {
        let price = Price(currency: "EUR", decimals: 1, amount: 1.2)
        
        XCTAssertTrue(price.currency == "EUR"
            && price.decimals == 1
            && price.amount == 1.2)
    }
    
    func testThatPriceIsNilForEmptyJson() {
        let emptyJson: JSONDictionary = [:]
        let price = PriceFactory.priceFromJSON(emptyJson)
        
        XCTAssertNil(price)
    }
    
    func testThatPriceIsNilForMalformatedAmountJson() {
        let priceJson: JSONDictionary = [
            "currency": "EUR",
            "decimals": 1,
            "amount": "Ten"
        ]
        let price = PriceFactory.priceFromJSON(priceJson)
        
        XCTAssertNil(price)
    }
    
    func testThatPriceCanBeCreatedFromJson() {
        let priceJson: JSONDictionary = [
            "currency": "EUR",
            "decimals": 1,
            "amount": "1.2"
        ]
        let price = PriceFactory.priceFromJSON(priceJson)
        
        XCTAssertTrue(price?.currency == "EUR"
            && price?.decimals == 1
            && price?.amount == 1.2)
    }
    
    func testThatPriceFormattedStringIsCorrect() {
        let price = Price(currency: "EUR", decimals: 1, amount: 4216.4)
        let formattedPriceString = price.formattedString(locale: Locale(identifier: "nl_NL"))
        XCTAssertEqual(formattedPriceString, "€ 4.216,4")
    }
    
}
