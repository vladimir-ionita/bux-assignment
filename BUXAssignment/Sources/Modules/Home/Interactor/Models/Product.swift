//
//  Product.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 06/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

typealias JSONDictionary = [String: Any]

class Product {
    let identifier: String
    let name: String
    let symbol: String
    var currentPrice: Price
    let closingPrice: Price
    
    var roi: Double {
        return (currentPrice.amount - closingPrice.amount) / closingPrice.amount * 100
    }
    
    init(identifier: String, name: String, symbol: String, currentPrice: Price, closingPrice: Price) {
        self.identifier = identifier
        self.name = name
        self.symbol = symbol
        self.currentPrice = currentPrice
        self.closingPrice = closingPrice
    }
}

extension Product {
    func formatedRoi() -> String {
        let roundedRoi = (roi * 100).rounded() / 100
        
        if roundedRoi >= 0 {
            return String(format: "+%.2f%%", roundedRoi)
        } else {
            return String(format: "%.2f%%", roundedRoi)
        }
    }
}
