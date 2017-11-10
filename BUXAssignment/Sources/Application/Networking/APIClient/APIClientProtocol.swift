//
//  APIClientProtocol.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

typealias APIClientResult = ((JSONDictionary?, Error?) -> Void)

protocol APIClientProtocol {
    func get(url: URL, headers: [String:String], completion: @escaping APIClientResult)
}
