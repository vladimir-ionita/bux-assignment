//
//  HomeViewControllerTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class HomeViewControllerTest: XCTestCase {
    var viewController: HomeViewController!
    var mockViewOutput: MockHomeViewOutput!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = (navigationController.topViewController as! HomeViewController)
        viewController.preloadView()
        
        mockViewOutput = MockHomeViewOutput()
        mockViewOutput.view = viewController
        
        viewController.output = mockViewOutput
        
        UIApplication.shared.keyWindow!.rootViewController = navigationController
    }
    
    func testThatViewControllerLocalizesStrings() {
        XCTAssertEqual(viewController.screenDescription.text,
                       NSLocalizedString("HOME_SCREEN_DESCRIPTION", comment: ""))
        XCTAssertEqual(viewController.productIdentifierTextField.placeholder,
                       NSLocalizedString("HOME_PRODUCT_IDENTIFIER_PLACEHOLDER", comment: ""))
        XCTAssertEqual(viewController.checkProductButton.title(for: .normal),
                       NSLocalizedString("HOME_GET_REAL_TIME_UPDATES_BUTTON_TITLE", comment: ""))
    }
    
    func testThatCheckProductButtonGetsEnabledWhenTextFieldHasData() {
        let textField = viewController.productIdentifierTextField!
        textField.text = "26608"
        
        viewController.textFieldDidChange(textField)
        XCTAssertTrue(viewController.checkProductButton.isEnabled)
    }
    
    func testThatCheckProductButtonGetsDisabledWhenTextFieldHasNoData() {
        let textField = viewController.productIdentifierTextField!
        textField.text = ""
        
        viewController.textFieldDidChange(textField)
        XCTAssertFalse(viewController.checkProductButton.isEnabled)
    }
    
    func testThatTappingKeyboardGoButtonWhenTextFieldIsEmptyDoesNotMakeARequestsToPresenter() {
        let textField = viewController.productIdentifierTextField!
        _ = viewController.textFieldShouldReturn(textField)
        
        XCTAssertFalse(mockViewOutput.checkProductMethodCalled)
    }
    
    func testThatTappingKeyboardGoButtonWhenTextFieldIsNotEmptyMakesARequestsToPresenter() {
        let textField = viewController.productIdentifierTextField!
        textField.text = "26608"
        _ = viewController.textFieldShouldReturn(textField)
        
        XCTAssertTrue(mockViewOutput.checkProductMethodCalled)
    }
    
    func testThatTappingCheckProductButtonMakesARequestsToPresenter() {
        viewController.productIdentifierTextField.text = "26608"
        viewController.checkProductButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(mockViewOutput.checkProductMethodCalled)
    }
    
    func testThatViewControllerWillShowAnErrorIfProductIdentifierIsWrong() {
        mockViewOutput.invalidIdentifier = true
        viewController.checkProductButtonTapped()
        
        XCTAssertNotNil(viewController.presentedViewController)
    }
}
