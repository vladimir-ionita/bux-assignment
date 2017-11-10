//
//  ProductServiceProtocol.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

typealias ProductServiceResult = ((Product?, Error?) -> Void)

protocol ProductServiceProtocol {
    func fetchProduct(identifier: String, completion: @escaping ProductServiceResult)
}
