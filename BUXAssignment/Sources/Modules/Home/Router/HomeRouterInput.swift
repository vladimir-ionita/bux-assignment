//
//  HomeRouterInput.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

protocol HomeRouterInput: class {
    func showProductDetails(sourceController: UIViewController) -> ProductDetailsModuleInput
}
