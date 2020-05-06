//
//  HomePresenterTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 14/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment
import XCTest

class HomePresenterTest: XCTestCase {
    var presenter: HomePresenter!
    
    override func setUp() {
        super.setUp()
        
        presenter = HomePresenter()
    }
    
    func testThatPresenterRequestsInteractorForRealTimeUpdates() {
        let mockInteractorInput = MockHomeInteractorInput()
        presenter.interactor = mockInteractorInput
        
        presenter.checkProduct(productIdentifier: "26608")
        XCTAssertTrue(mockInteractorInput.getProductCalled)
    }
    
    func testThatWhenInteractorProvidesAProductPresenterRequestsTheRouterToOpenANewScreen() {
        presenter.view = realHomeViewController()
        
        let mockInteractorInput = MockHomeInteractorInput()
        mockInteractorInput.output = presenter
        presenter.interactor = mockInteractorInput
        
        let mockRouterInput = MockHomeRouterInput()
        presenter.router = mockRouterInput
        
        mockInteractorInput.nextProduct = Stubs.productStub()
        mockInteractorInput.fetchProduct(identifier: "26608")
        
        XCTAssertTrue(mockRouterInput.showProductDetailsCalled)
    }
    
    func testThatWhenInteractorProvidesAProductPresenterConfiguresProductDetailsModule() {
        presenter.view = realHomeViewController()
        
        let mockInteractorInput = MockHomeInteractorInput()
        mockInteractorInput.output = presenter
        presenter.interactor = mockInteractorInput
        
        let mockRouterInput = MockHomeRouterInput()
        presenter.router = mockRouterInput
        
        mockInteractorInput.nextProduct = Stubs.productStub()
        mockInteractorInput.fetchProduct(identifier: "26608")
        
        let mockProductDetailsModuleInput = presenter.productDetailsModule! as? MockProductDetailsModuleInput
        XCTAssertTrue(mockProductDetailsModuleInput!.configureModuleCalled)
    }
    
    func testThatWhenInteractorReturnsAResourceNotFoundErrorPresenterRequestsTheViewToShowAResourceNotFoundErrorMessage() {
        let mockViewInput = MockHomeViewInput()
        presenter.view = mockViewInput
        
        testError(error: HTTPClientError.ResourceNotFound)
        XCTAssertEqual(mockViewInput.lastErrorMessage, NSLocalizedString("HOME_RESOURCE_NOT_FOUND_ERROR_MESSAGE", comment: ""))
    }
    
    func testThatWhenInteractorReturnsAnUnauthorizedErrorPresenterRequestsTheViewToShowAnUnauthorizedErrorMessage() {
        let mockViewInput = MockHomeViewInput()
        presenter.view = mockViewInput
        
        testError(error: HTTPClientError.Unauthorized)
        XCTAssertEqual(mockViewInput.lastErrorMessage, NSLocalizedString("HOME_UNAUTHORIZED_ERROR_MESSAGE", comment: ""))
    }
    
    func testThatWhenInteractorReturnsAForbiddenErrorPresenterRequestsTheViewToShowAForbiddenErrorMessage() {
        let mockViewInput = MockHomeViewInput()
        presenter.view = mockViewInput
        
        testError(error: HTTPClientError.Forbidden)
        XCTAssertEqual(mockViewInput.lastErrorMessage, NSLocalizedString("HOME_FORBIDDEN_ERROR_MESSAGE", comment: ""))
    }
    
    func testThatWhenInteractorReturnsANetworkErrorPresenterRequestsTheViewToShowANetworErrorMessage() {
        let mockViewInput = MockHomeViewInput()
        presenter.view = mockViewInput
        
        testError(error: HTTPClientError.NetworkError)
        XCTAssertEqual(mockViewInput.lastErrorMessage, NSLocalizedString("HOME_NETWORK_ERROR_MESSAGE", comment: ""))
    }
    
    func testThatWhenInteractorReturnsAnErrorPresenterRequestsTheViewToShowANetworErrorMessage() {
        let mockViewInput = MockHomeViewInput()
        presenter.view = mockViewInput
        
        testError(error: APIClientError.SerializerError)
        XCTAssertEqual(mockViewInput.lastErrorMessage, NSLocalizedString("HOME_NETWORK_ERROR_MESSAGE", comment: ""))
    }
}

// MARK: - Private Methods
private extension HomePresenterTest {
    func testError(error: Error) {
        let mockInteractorInput = MockHomeInteractorInput()
        mockInteractorInput.output = presenter
        presenter.interactor = mockInteractorInput
        
        mockInteractorInput.nextError = error
        mockInteractorInput.fetchProduct(identifier: "26608")
    }
    
    func realHomeViewController() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
        let viewController = navigationController.topViewController as! HomeViewController
        viewController.preloadView()
        
        return viewController
    }
}
