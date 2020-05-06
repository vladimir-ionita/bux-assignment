//
//  SocketEventInterpreter.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 15/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import Foundation

enum EventType: String {
    case ConnectionSucceed = "connect.connected"
    case ConnectionFailed = "connect.failed"
    case PriceUpdated = "trading.quote"
}

struct PriceUpdatedEventBody {
    let identifier: String
    let currentPrice: Double
}

class ChannelEventsParser {
    func parseEventMessage(eventMessage: String) -> (eventType: EventType, eventBody: JSONDictionary?)? {
        guard let jsonDictionary = jsonDictionaryFromJsonString(eventMessage) else {
            return nil
        }
        
        guard
            let eventTypeString = jsonDictionary["t"] as? String,
            let eventType = EventType(rawValue: eventTypeString) else
        {
            return nil
        }
        
        let eventBody = jsonDictionary["body"] as? JSONDictionary
        return (eventType, eventBody)
    }
    
    func parsePriceUpdatedEventBody(_ eventBodyJson: JSONDictionary) -> PriceUpdatedEventBody? {
        guard
            let identifier = eventBodyJson["securityId"] as? String,
            let currentPriceString = eventBodyJson["currentPrice"] as? String else
        {
            return nil
        }
        
        guard let currentPrice = Double(currentPriceString) else {
            return nil
        }
        
        return PriceUpdatedEventBody(identifier: identifier,
                                     currentPrice: currentPrice)
    }
}

// MARK: - Private Methods
private extension ChannelEventsParser {
    func jsonDictionaryFromJsonString(_ jsonString: String) -> JSONDictionary? {
        guard
            let jsonData = jsonString.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let jsonDictionary = jsonObject as? JSONDictionary else
        {
            return nil
        }
        
        return jsonDictionary
    }
}
