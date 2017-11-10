//
//  PriceFactory.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 12/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

final class PriceFactory {
    static public func priceFromJSON(_ json: JSONDictionary) -> Price? {
        guard
            let currency = json["currency"] as? String,
            let decimals = json["decimals"] as? Int,
            let amountString = json["amount"] as? String else
        {
            return nil
        }
        
        guard let amount = Double(amountString) else {
            return nil
        }
        
        return Price(currency: currency,
                     decimals: decimals,
                     amount: amount)
    }
}
