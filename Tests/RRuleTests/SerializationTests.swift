//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

@testable import RecurrenceKit
import XCTest

final class SerializationTests: XCTestCase {

    func testRRuleSerialization() {
        let components = DateComponents(
            timeZone: TimeZone(identifier: "GMT")!,
            year: 2010,
            month: 1,
            day: 1
        )

        let rule = RRule(.frequency(.weekly), .until(components))
        let string = rule.serialized
        let expected = "RRULE:FREQ=WEEKLY;UNTIL=20100101T000000Z"

        XCTAssertEqual(string, expected)
    }

    func testDTStartSerialization() {
        let components = DateComponents(
            timeZone: TimeZone(identifier: "America/New_York")!,
            year: 1997,
            month: 9,
            day: 2,
            hour: 09
        )

        let start = DTStart(components: components)
        let string = start.serialized
        let expected = "DTSTART;TZID=America/New_York:19970902T090000"

        XCTAssertEqual(string, expected)
    }

    func testDTStartSerializationGMT() {
        let components = DateComponents(
            timeZone: TimeZone(identifier: "GMT")!,
            year: 1997,
            month: 9,
            day: 2,
            hour: 09
        )

        let start = DTStart(components: components)
        let string = start.serialized
        let expected = "DTSTART:19970902T090000Z"

        XCTAssertEqual(string, expected)
    }

    func testDTStartSerializationNoTimeZone() {
        let components = DateComponents(
            timeZone: nil,
            year: 1997,
            month: 9,
            day: 2,
            hour: 09
        )

        let start = DTStart(components: components)
        let string = start.serialized
        let expected = "DTSTART:19970902T090000"

        XCTAssertEqual(string, expected)
    }

    func testSetSerializationUTC() {
        let components = DateComponents(
            timeZone: TimeZone(identifier: "GMT")!,
            year: 1997,
            month: 9,
            day: 2,
            hour: 09
        )

        let set = RRuleSet(
            start: DTStart(components: components),
            rule: RRule(.frequency(.weekly))
        )
        let string = set.serialized
        let expected = """
        DTSTART:19970902T090000Z
        RRULE:FREQ=WEEKLY
        """

        XCTAssertEqual(string, expected)
    }

    func testSetSerializationNewYork() {
        let components = DateComponents(
            timeZone: TimeZone(identifier: "America/New_York")!,
            year: 1997,
            month: 9,
            day: 2,
            hour: 09
        )

        let set = RRuleSet(
            start: DTStart(components: components),
            rule: RRule(.frequency(.weekly))
        )
        let string = set.serialized
        let expected = """
        DTSTART;TZID=America/New_York:19970902T090000
        RRULE:FREQ=WEEKLY
        """

        XCTAssertEqual(string, expected)
    }
}
