//
//  ProductService.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 13/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

class ProductService: ProductServiceProtocol {
    private let apiClient: APIClientProtocol
    private struct Constants {
        static let productsEndpointFormat = "https://api.beta.getbux.com/core/16/products/%@"
    }
    
    init(apiClient: APIClientProtocol = APIClient(httpClient: HTTPClient())) {
        self.apiClient = apiClient
    }
    
    func fetchProduct(identifier: String, completion: @escaping ProductServiceResult) {
        let urlString = String(format: Constants.productsEndpointFormat, identifier)
        let url = URL(string: urlString)!
        
        let headers = [
            HTTPHeaders.authorization: HTTPRequestHeadersDefaults.authorizationToken,
            HTTPHeaders.accept: HTTPRequestHeadersDefaults.acceptedResponseFormat,
            HTTPHeaders.acceptLanguage: HTTPRequestHeadersDefaults.acceptedLanguages
        ]
        
        apiClient.get(url: url, headers: headers) { (jsonDictionary, error) in
            if let jsonDictionary = jsonDictionary {
                if let product = ProductFactory.productFromJson(jsonDictionary) {
                    completion(product, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
