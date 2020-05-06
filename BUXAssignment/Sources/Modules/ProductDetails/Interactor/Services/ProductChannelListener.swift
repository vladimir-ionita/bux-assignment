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
    private var webSocketIsConnected = false
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
        webSocket!.disconnect()
        webSocket!.delegate = nil
    }
}

// MARK: - ProductChannelListenerInput
extension ProductChannelListener: ProductChannelListenerInput {
    func subscribeToChannel(productIdentifier: String) {
        if webSocketIsConnected {
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

// MARK: - Private Methods
private extension ProductChannelListener {
    func request() -> URLRequest {
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
    
    func sendSubscribeMessage(productIdentifier: String) {
        let message = ProductChannelMessagesFactory.subscribeMessage(identifier: productIdentifier)
        webSocket.write(data: message)
    }
    
    func sendUnsubscribeMessage(productIdentifier: String) {
        let message = ProductChannelMessagesFactory.unsubscribeMessage(identifier: productIdentifier)
        webSocket.write(data: message)
    }
}

// MARK: - Delegates
// MARK: WebSocketDelegate
extension ProductChannelListener: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            webSocketIsConnected = true
        case .disconnected(let reason, let code):
            print("Disconnected.\nCode: %@\nReason: %@", code, reason)
            webSocketIsConnected = false
        case .text(let string):
            print("Received text: \(string)")
            websocketDidReceiveMessage(message: string)
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            webSocketIsConnected = false
        case .error(let error):
            if let error = error {
                print("Connetion error: %@", error)
            }
            webSocketIsConnected = false
        }
    }
    
    private func websocketDidReceiveMessage(message: String) {
        guard let event = eventsParser.parseEventMessage(eventMessage: message) else {
            return
        }
        
        switch event.eventType {
        case .ConnectionSucceed:
            if subscriptionProductIdentifier != nil && !subscriptionProductIdentifier!.isEmpty {
                sendSubscribeMessage(productIdentifier: subscriptionProductIdentifier!)
            }
        case .ConnectionFailed:
            delegate?.didEncounterNetworkIssues()
        case .PriceUpdated:
            if let eventBody = event.eventBody {
                if let quoteUpdatedEventBody = eventsParser.parsePriceUpdatedEventBody(eventBody) {
                    delegate?.didReceiveQuoteUpdate(quoteUpdatedEventBody)
                }
            }
        }
    }
}
