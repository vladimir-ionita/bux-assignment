//
//  HomeInitializer.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

class HomeModuleInitializer: NSObject {
    @IBOutlet weak var homeViewController: HomeViewController!
    
    override func awakeFromNib() {
        let configurator = HomeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: homeViewController)
    }
}
