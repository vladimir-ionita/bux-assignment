//
//  Price.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 07/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

struct Price {
    let currency: String
    let decimals: Int
    var amount: Double
}

extension Price {
    static private var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    func formattedString(locale: Locale = Locale.current) -> String? {
        type(of: self).formatter.locale = locale
        
        type(of: self).formatter.maximumFractionDigits = decimals
        type(of: self).formatter.currencyCode = currency

        return type(of: self).formatter.string(from: NSNumber(value: amount))
    }
}
