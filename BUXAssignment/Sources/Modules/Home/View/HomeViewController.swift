//
//  HomeViewController.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var output: HomeViewOutput!
    
    @IBOutlet var screenDescription: UILabel!
    @IBOutlet var productIdentifierTextField: UITextField!
    @IBOutlet var checkProductButton: UIButton!
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
}

// MARK: - Actions
extension HomeViewController {
    @IBAction func checkProductButtonTapped() {
        output.checkProduct(productIdentifier: productIdentifierTextField.text!)
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        checkProductButton.isEnabled = textField.text != nil && !textField.text!.isEmpty
    }
}

// MARK: - Private Methods
private extension HomeViewController {
    func setupInitialState() {
        customizeCheckProductButton()
        localize()
    }
    
    func customizeCheckProductButton() {
        checkProductButton.layer.cornerRadius = 4
        checkProductButton.layer.borderWidth = 1.5
        checkProductButton.layer.borderColor = UIColor.bxDarkOrange.cgColor
        checkProductButton.setTitleColor(UIColor.bxLightOrange, for: .disabled)
        checkProductButton.setBackgroundImage(UIImage(color: UIColor.bxGray), for: .highlighted)
    }
    
    func localize() {
        screenDescription.text = NSLocalizedString("HOME_SCREEN_DESCRIPTION", comment: "Screen description")
        productIdentifierTextField.placeholder = NSLocalizedString("HOME_PRODUCT_IDENTIFIER_PLACEHOLDER", comment: "Identifier placeholder")
        
        let updatesButtonTitle = NSLocalizedString("HOME_GET_REAL_TIME_UPDATES_BUTTON_TITLE", comment: "Get updates title")
        checkProductButton.setTitle(updatesButtonTitle, for: .normal)
    }
}

extension HomeViewController: HomeViewInput {
    func showError(errorMessage: String) {
        self.present(alertWithMessage(message: errorMessage), animated: true, completion: nil)
    }
    
    private func alertWithMessage(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelActionTitle = NSLocalizedString("HOME_DIALOG_BUTTON_CANCEL", comment: "Cance Action Title")
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        return alertController
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            checkProductButtonTapped()
            return false
        }
        
        return true
    }
}
