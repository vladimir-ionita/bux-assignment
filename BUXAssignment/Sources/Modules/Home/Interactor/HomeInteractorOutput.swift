//
//  HomeInteractorOutput.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

protocol HomeInteractorOutput: class {
    func productFetchSucceed(_ product: Product)
    func productFetchFailed(error: Error?)
}
