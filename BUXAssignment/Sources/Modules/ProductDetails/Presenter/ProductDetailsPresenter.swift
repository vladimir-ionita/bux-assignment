//
//  ProductDetailsPresenter.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class ProductDetailsPresenter {
    weak var view: ProductDetailsViewInput!
    var interactor: ProductDetailsInteractorInput!
    
    private var product: Product!
    private var viewIsReadySemaphore: DispatchGroup?
    private var throttler: Throttler = Throttler(seconds: 1)
    
    init() {
        viewIsReadySemaphore = DispatchGroup()
        viewIsReadySemaphore!.enter()
        viewIsReadySemaphore!.enter()
        
        viewIsReadySemaphore?.notify(queue: DispatchQueue.main) { [weak self] in
            guard let welf = self else { return }
            
            welf.viewIsReadySemaphore = nil
            welf.view.populateProductDetails(productName: welf.product.name,
                                             closingPrice: welf.product.closingPrice.formattedString()!,
                                             currentPrice: welf.product.currentPrice.formattedString()!,
                                             roi: welf.product.formatedRoi(),
                                             roiIsPositive: welf.product.roi >= 0)
            welf.interactor.subscribeToRealTimeFeedChannel(for: welf.product.identifier)
        }
    }
}

// MARK: - ProductDetailsModuleInput
extension ProductDetailsPresenter: ProductDetailsModuleInput {
    func configureModule(product: Product) {
        self.product = product
        viewIsReadySemaphore?.leave()
    }
}

// MARK: - ProductDetailsViewOutput
extension ProductDetailsPresenter: ProductDetailsViewOutput {
    func viewIsReady() {
        viewIsReadySemaphore?.leave()
    }
    
    func viewWillDisappear() {
        interactor.unsubscribeFromRealTimeFeedChannel(for: product.identifier)
    }
}

// MARK: - ProductDetailsInteractorOutput
extension ProductDetailsPresenter: ProductDetailsInteractorOutput {
    func didReceivePriceUpdate(_ priceDescription: PriceUpdatedEventBody) {
        throttler.throttle { [weak self] in
            DispatchQueue.main.async {
                guard let welf = self else {
                    return
                }
                
                welf.product.currentPrice.amount = priceDescription.currentPrice
                welf.view.updateCurrentPriceAndRoi(currentPrice: welf.product.currentPrice.formattedString()!,
                                                   roi: welf.product.formatedRoi(),
                                                   roiIsPositive: welf.product.roi >= 0)
            }
        }
    }
    
    func didEncounterNetworkIssues() {
        // TODO: Implement method
    }
}
