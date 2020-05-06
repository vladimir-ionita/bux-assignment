//
//  ProductDetailsViewControllerTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class ProductDetailsViewControllerTest: XCTestCase {
    var viewController: ProductDetailsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        viewController = (storyboard.instantiateInitialViewController() as! ProductDetailsViewController)
        viewController.preloadView()
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
//    func testThatViewPopulatesTheScreenWhenItReceivesARequestFromPresenter() {
//        let product = productStub()
//        viewController.populateView(product: product)
//
//        XCTAssertEqual(viewController.productNameLabel.text, product.name)
//        XCTAssertEqual(viewController.productIdentifierLabel.text, product.identifier)
//        XCTAssertEqual(viewController.closingPriceLabel.text, product.closingPrice.formattedString())
//        XCTAssertEqual(viewController.currentPriceLabel.text, product.currentPrice.formattedString())
//        XCTAssertEqual(viewController.roiLabel.text, String(product.roi))
//    }
}
