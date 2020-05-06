//
//  HomeConfigurator.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class HomeModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? HomeViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: HomeViewController) {
        let router = HomeRouter()
        
        let presenter = HomePresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = HomeInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
    }
}
