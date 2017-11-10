//
//  ProductDetailsConfigurator.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class ProductDetailsConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? ProductDetailsViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: ProductDetailsViewController) {
        let presenter = ProductDetailsPresenter()
        presenter.view = viewController
        
        let interactor = ProductDetailsInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
    }
}
