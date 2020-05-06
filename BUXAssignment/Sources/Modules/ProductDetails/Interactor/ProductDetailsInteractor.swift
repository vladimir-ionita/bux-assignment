//
//  ProductDetailsInteractor.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class ProductDetailsInteractor {
    weak var output: ProductDetailsInteractorOutput!
    private let channelListener: ProductChannelListenerInput
    private var productIdentifier: String?
    
    init(channelListener: ProductChannelListenerInput = ProductChannelListener()) {
        self.channelListener = channelListener
        (channelListener as! ProductChannelListener).delegate = self
    }
}

// MARK: - ProductDetailsInteractorInput
extension ProductDetailsInteractor: ProductDetailsInteractorInput {
    func subscribeToRealTimeFeedChannel(for productIdentifier: String) {
        self.productIdentifier = productIdentifier
        channelListener.subscribeToChannel(productIdentifier: productIdentifier)
    }
    
    func unsubscribeFromRealTimeFeedChannel(for productIdentifier: String) {
        self.productIdentifier = nil
        channelListener.unsubscribeFromChannel(productIdentifier: productIdentifier)
    }
}

// MARK: - ProductChannelListenerOutput
extension ProductDetailsInteractor: ProductChannelListenerOutput {
    func didReceiveQuoteUpdate(_ priceUpdatedEventBody: PriceUpdatedEventBody) {
        guard let identifier = productIdentifier, !identifier.isEmpty else {
            return
        }
        
        if priceUpdatedEventBody.identifier == identifier {
            output.didReceivePriceUpdate(priceUpdatedEventBody)
        }
    }
    
    func didEncounterNetworkIssues() {
        output.didEncounterNetworkIssues()
    }
}
