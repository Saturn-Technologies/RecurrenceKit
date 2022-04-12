@testable import RecurrenceKit
import XCTest

final class RRuleTests: XCTestCase {

    func assertRuleSet(_: RRuleSet, expandsTo _: [DateComponents]) {
//        let result = set.all()
//        )
    }

    func testYearly() {
        let set = RRuleSet(start: DTStart(components: datetime(1997, 9, 2, 9, 0)),
                           rule: RRule(.frequency(.yearly),
                                       .count(3)))

        assertRuleSet(set, expandsTo: [datetime(1997, 9, 2, 9, 0),
                                       datetime(1998, 9, 2, 9, 0),
                                       datetime(1999, 9, 2, 9, 0)])
    }

    func testParseDate() throws {
        let date = try DateComponents(rfcString: "19970105")
        XCTAssertEqual(date, DateComponents(year: 1997,
                                            month: 1,
                                            day: 5))

        let withTime = try DateComponents(rfcString: "19970105T083000")
        XCTAssertEqual(withTime, DateComponents(year: 1997,
                                                month: 1,
                                                day: 5,
                                                hour: 8,
                                                minute: 30,
                                                second: 0))
    }

    func testParseDTStart() throws {
        // local
        let local = try DTStart(rfcString: """
        DTSTART:19970714T133000
        """)
        XCTAssertEqual(local.timeZoneID, nil)

        // utc
        let utc = try DTStart(rfcString: """
        DTSTART:19970714T133000Z
        """)
        XCTAssertEqual(utc.timeZoneID, "GMT")

        // with time zone
        let newYork = try DTStart(rfcString: """
        DTSTART;TZID=America/New_York:19970714T133000
        """)
        XCTAssertEqual(newYork.timeZoneID, "America/New_York")
    }

    func testExample() throws {
        let x = try RRuleSet(rfcString: """
        DTSTART;TZID=America/New_York:19970105T083000
        RRULE:FREQ=YEARLY;WKST=TU;INTERVAL=2;BYMONTH=1;BYDAY=SU;BYHOUR=8,9;BYMINUTE=30
        """)
    }
}
