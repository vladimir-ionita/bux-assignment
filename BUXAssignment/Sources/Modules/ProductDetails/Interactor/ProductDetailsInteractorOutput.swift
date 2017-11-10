//
//  ProductDetailsInteractorOutptu.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

protocol ProductDetailsInteractorOutput: class {
    func didReceivePriceUpdate(_ priceDescription: PriceUpdatedEventBody)
    func didEncounterNetworkIssues()
}
