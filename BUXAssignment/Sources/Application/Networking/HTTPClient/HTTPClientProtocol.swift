//
//  HTTPClientProtocol.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

typealias HTTPResult = (Data?, HTTPClientError?) -> Void

protocol HTTPClientProtocol {
    func get(request: URLRequest, completion: HTTPResult?)
}
