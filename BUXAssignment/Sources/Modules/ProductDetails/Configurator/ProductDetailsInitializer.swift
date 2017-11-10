//
//  ProductDetailsInitializer.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class ProductDetailsInitializer: NSObject {
    @IBOutlet weak var productDetailsViewController: ProductDetailsViewController!
    
    override func awakeFromNib() {
        let configurator = ProductDetailsConfigurator()
        configurator.configureModuleForViewInput(viewInput: productDetailsViewController)
    }
}
