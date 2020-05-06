//
//  HomePresenter.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class HomePresenter {
    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
    weak var productDetailsModule: ProductDetailsModuleInput?
}

// MARK: - HomeViewOutput
extension HomePresenter: HomeViewOutput {
    func checkProduct(productIdentifier: String) {
        interactor.fetchProduct(identifier: productIdentifier)
    }
}

// MARK: - HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    func productFetchSucceed(_ product: Product) {
        let viewController = view as! UIViewController
        productDetailsModule = router.showProductDetails(sourceController: viewController)
        productDetailsModule!.configureModule(product: product)
    }
    
    func productFetchFailed(error: Error?) {
        view.showError(errorMessage: messageForError(error: error))
    }
    
    private func messageForError(error: Error?) -> String {
        if let error = error as? HTTPClientError {
            switch error {
            case .ResourceNotFound:
                return NSLocalizedString("HOME_RESOURCE_NOT_FOUND_ERROR_MESSAGE", comment: "Not found error")
            case .Unauthorized:
                return NSLocalizedString("HOME_UNAUTHORIZED_ERROR_MESSAGE", comment: "Unauthorized error")
            case .Forbidden:
                return NSLocalizedString("HOME_FORBIDDEN_ERROR_MESSAGE", comment: "Forbidden error")
            case .NetworkError:
                return NSLocalizedString("HOME_NETWORK_ERROR_MESSAGE", comment: "Network error")
            }
        }
        
        return NSLocalizedString("HOME_NETWORK_ERROR_MESSAGE", comment: "Network error")
        
    }
}
