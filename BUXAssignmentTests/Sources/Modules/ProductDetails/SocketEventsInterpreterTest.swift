//
//  SocketEventsInterpreterTest.swift
//  BUXAssignmentTests
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

@testable import BUXAssignment

import XCTest

class ChannelEventsParserTest: XCTestCase {
    func testThatEventsParserCanParseAConnectionSucceedEventMessage() {
        let eventsParser = ChannelEventsParser()
        let connectionSuccceedEvent = stringMessageFromJsonDictionary(connectionSucceedMessageJson())
        let event = eventsParser.parseEventMessage(eventMessage: connectionSuccceedEvent)

        XCTAssertTrue(event?.eventType == EventType.ConnectionSucceed)
    }

    func testThatEventsParserCanParseAConnectionFaieldEventMessage() {
        let eventsParser = ChannelEventsParser()
        let connectionFailedMessage = stringMessageFromJsonDictionary(connectionFailedMessageJson())
        let event = eventsParser.parseEventMessage(eventMessage: connectionFailedMessage)

        XCTAssertTrue(event?.eventType == EventType.ConnectionFailed)
    }

    func testThatEventsParserCanParseAnPriceUpdateEventMessage() {
        let eventsParser = ChannelEventsParser()
        let priceUpdateMessage = stringMessageFromJsonDictionary(priceUpdateMessageJson())
        let event = eventsParser.parseEventMessage(eventMessage: priceUpdateMessage)

        XCTAssertTrue(event?.eventType == EventType.PriceUpdated)
        if let eventBody = event?.eventBody {
            let priceUpdatedEventBody = eventsParser.parsePriceUpdatedEventBody(eventBody)
            XCTAssertNotNil(priceUpdatedEventBody)
        }
    }
    
//    func testThatSocketEventsInterpreterWillReturnEventWithNilBodyForInvalidPriceUdateEventMessage() {
//        let eventsInterpreter = SocketEventsInterpreter()
//        let invalidPriceUpdateMessage = stringMessageFromJsonDictionary(invalidPriceUpdateMessageJson())
//        let event = eventsInterpreter.parseEventMessage(message: invalidPriceUpdateMessage)
//
//        XCTAssertTrue(event?.eventType == EventType.ProductPriceUpdated)
//        XCTAssertNil(event?.body?.currentPrice)
//    }
//
//    func testThatSocketEventsInterpreterWillReturnNilForUnknownEventMessage() {
//        let eventsInterpreter = SocketEventsInterpreter()
//        let unknownEventMessage = stringMessageFromJsonDictionary(unknownEventMessageJson())
//        let event = eventsInterpreter.parseEventMessage(message: unknownEventMessage)
//
//        XCTAssertNil(event)
//    }
//
//    func testThatSocketEventsInterpreterWillReturnNilForInvalidJsonMessages() {
//        let eventsInterpreter = SocketEventsInterpreter()
//        let invalidJsonMessage = "invalid json message"
//        let event = eventsInterpreter.parseEventMessage(message: invalidJsonMessage)
//
//        XCTAssertNil(event)
//    }
    
    
    
    // MARK: - Private Message
    
    private func connectionSucceedMessageJson() -> JSONDictionary {
        return ["t": "connect.connected"]
    }
    
    private func connectionFailedMessageJson() -> JSONDictionary {
        return ["t": "connect.failed"]
    }
    
    private func priceUpdateMessageJson() -> JSONDictionary {
        return [
            "t": "trading.quote",
            "body": [
                "currentPrice": "13621.6",
                "securityId": "sb26493",
                "timeStamp": 1510755462446,
            ]
        ]
    }
    
    private func invalidPriceUpdateMessageJson() -> JSONDictionary {
        return ["t": "trading.quote"]
    }
    
    private func unknownEventMessageJson() -> JSONDictionary {
        return ["t": "event.unknown"]
    }
    
    private func stringMessageFromJsonDictionary(_ jsonDictionary: JSONDictionary) -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
        return String(data: jsonData, encoding: .utf8)!
    }
}
