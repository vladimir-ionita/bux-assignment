//
//  HomeRouterTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class HomeRouterTest: XCTestCase {
    var router: HomeRouter!
    
    override func setUp() {
        super.setUp()
        
        router = HomeRouter()
    }
    
    func testThatWhenRouterReceivesTheRequestToShowProductDetailsItWillOpenANewScreen() {
        let viewController = realHomeViewController()
        let productDetailsModule = router.showProductDetails(sourceController: viewController)
        let presenter = productDetailsModule as! ProductDetailsPresenter
        
        XCTAssertTrue(presenter.view is ProductDetailsViewController)
    }
    
    private func realHomeViewController() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        let viewController = navigationController.topViewController as! HomeViewController
        viewController.preloadView()
        
        return viewController
    }
}
