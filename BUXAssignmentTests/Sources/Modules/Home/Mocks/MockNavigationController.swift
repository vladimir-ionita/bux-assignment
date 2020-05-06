//
//  MockNavigationController.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
    private (set) var pushViewControllerCalled = false
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
    }
}
