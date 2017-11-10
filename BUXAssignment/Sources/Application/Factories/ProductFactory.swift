//
//  ProductFactory.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 12/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

final class ProductFactory {
    static public func productFromJson(_ json: JSONDictionary) -> Product? {
        guard
            let identifier = json["securityId"] as? String,
            let name = json["displayName"] as? String,
            let symbol = json["symbol"] as? String,
            let currentPriceJson = json["currentPrice"] as? JSONDictionary,
            let closingPriceJson = json["closingPrice"] as? JSONDictionary else
        {
            return nil
        }
        
        guard
            let currentPrice = PriceFactory.priceFromJSON(currentPriceJson),
            let closingPrice = PriceFactory.priceFromJSON(closingPriceJson) else
        {
            return nil
        }
        
        return Product(identifier: identifier,
                       name: name,
                       symbol: symbol,
                       currentPrice: currentPrice,
                       closingPrice: closingPrice)
    }
}
