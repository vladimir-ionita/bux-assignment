//
//  HomeRouter.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class HomeRouter: HomeRouterInput {
    func showProductDetails(sourceController: UIViewController) -> ProductDetailsModuleInput {
        let productDetailsScreen = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateInitialViewController() as! ProductDetailsViewController   
        sourceController.navigationController?.pushViewController(productDetailsScreen, animated: true)
        
        return productDetailsScreen.output as! ProductDetailsModuleInput
    }
}
