//
//  MockProductDetailsViewInput.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import UIKit

class MockProductDetailViewInput: UIViewController, ProductDetailsViewInput {
    var output: ProductDetailsViewOutput!
    
    var populateViewWasCalled = false
    var populateViewWasCalledHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    func populateProductDetails(productName: String, closingPrice: String, currentPrice: String, roi: String, roiIsPositive: Bool) {
        populateViewWasCalled = true
        populateViewWasCalledHandler?()
    }
    
    func updateCurrentPriceAndRoi(currentPrice: String, roi: String, roiIsPositive: Bool) {
        
    }
}
