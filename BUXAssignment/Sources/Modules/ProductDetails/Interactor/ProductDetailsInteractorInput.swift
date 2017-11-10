//
//  ProductDetailsInteractorInput.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

protocol ProductDetailsInteractorInput: class {
    func subscribeToRealTimeFeedChannel(for productIdentifier: String)
    func unsubscribeFromRealTimeFeedChannel(for productIdentifier: String)
}
