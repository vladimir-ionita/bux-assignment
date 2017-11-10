//
//  HomeInteractor.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class HomeInteractor {
    weak var output: HomeInteractorOutput!
    private let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }   
}

extension HomeInteractor: HomeInteractorInput {
    func fetchProduct(identifier: String) {
        productService.fetchProduct(identifier: identifier) { (product, error) in
            if let product = product {
                self.output.productFetchSucceed(product)
            } else {
                self.output.productFetchFailed(error: error)
            }
        }
    }
}
