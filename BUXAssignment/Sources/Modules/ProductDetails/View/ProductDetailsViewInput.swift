//
//  ProductDetailsViewInput.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

protocol ProductDetailsViewInput: class {
    func populateProductDetails(productName: String,
                                closingPrice: String,
                                currentPrice: String,
                                roi: String,
                                roiIsPositive: Bool)
    func updateCurrentPriceAndRoi(currentPrice: String,
                                  roi: String,
                                  roiIsPositive: Bool)
}
