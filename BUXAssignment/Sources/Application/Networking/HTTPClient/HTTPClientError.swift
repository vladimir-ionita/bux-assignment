//
//  HTTPErrors.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 17/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

enum HTTPClientError: Error {
    case ResourceNotFound
    case Unauthorized
    case Forbidden
    case NetworkError
}
