//
//  ProductChannelListener.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Starscream

protocol ProductChannelListenerInput: class {
    func subscribeToChannel(productIdentifier: String)
    func unsubscribeFromChannel(productIdentifier: String)
}

protocol ProductChannelListenerOutput: class {
    func didReceiveQuoteUpdate(_ priceUpdatedEventBody: PriceUpdatedEventBody)
    func didEncounterNetworkIssues()
}

class ProductChannelListener {
    weak var delegate: ProductChannelListenerOutput?
    private var webSocket: WebSocket!
    private let eventsParser = ChannelEventsParser()
    private var subscriptionProductIdentifier: String?
    private struct Constants {
        static let channelSubscriptionEndpoint = "https://rtf.beta.getbux.com/subscriptions/me"
    }
    
    init() {
        webSocket = WebSocket(request: request())
        webSocket!.delegate = self
    }
    
    init(webSocket: WebSocket) {
        self.webSocket = webSocket
        webSocket.delegate = self
    }
    
    deinit {
        webSocket!.disconnect(forceTimeout: 0)
        webSocket!.delegate = nil
    }
    
    
    // MARK: - Private Methods
    
    private func request() -> URLRequest {
        var request = URLRequest(url: URL(string: Constants.channelSubscriptionEndpoint)!)
        
        let headers = [
            HTTPHeaders.authorization: HTTPRequestHeadersDefaults.authorizationToken,
            HTTPHeaders.acceptLanguage: HTTPRequestHeadersDefaults.acceptedLanguages
        ]
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    private func sendSubscribeMessage(productIdentifier: String) {
        let message = ProductChannelMessagesFactory.subscribeMessage(identifier: productIdentifier)
        webSocket.write(data: message)
    }
    
    private func sendUnsubscribeMessage(productIdentifier: String) {
        let message = ProductChannelMessagesFactory.unsubscribeMessage(identifier: productIdentifier)
        webSocket.write(data: message)
    }
}

extension ProductChannelListener: ProductChannelListenerInput {
    func subscribeToChannel(productIdentifier: String) {
        if webSocket.isConnected {
            sendSubscribeMessage(productIdentifier: productIdentifier)
        } else {
            subscriptionProductIdentifier = productIdentifier
            webSocket.connect()
        }
    }
    
    func unsubscribeFromChannel(productIdentifier: String) {
        sendUnsubscribeMessage(productIdentifier: productIdentifier)
    }
}

extension ProductChannelListener: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
//        reconnectedSuccessfully()
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
//        reconnect()?
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        guard let event = eventsParser.parseEventMessage(eventMessage: text) else {
            return
        }
        
        switch event.eventType {
        case .ConnectionSucceed:
            if subscriptionProductIdentifier != nil && !subscriptionProductIdentifier!.isEmpty {
                sendSubscribeMessage(productIdentifier: subscriptionProductIdentifier!)
            }
        case .ConnectionFailed:
            delegate?.didEncounterNetworkIssues()
//            reconnect()
        case .PriceUpdated:
            if let eventBody = event.eventBody {
                if let quoteUpdatedEventBody = eventsParser.parsePriceUpdatedEventBody(eventBody) {
                    delegate?.didReceiveQuoteUpdate(quoteUpdatedEventBody)
                }
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}
