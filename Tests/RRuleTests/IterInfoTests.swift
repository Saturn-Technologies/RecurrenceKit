
//
//  File 2.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

@testable import RRule
import XCTest

final class IterInfoTests: XCTestCase {

    func testLeapYear() {
        func isLeapYear(_ year: Int) -> Bool {
            IterInfo(.init([])).isLeapYear(year)
        }

        XCTAssertTrue(isLeapYear(2016))
        XCTAssertFalse(isLeapYear(2015))

        XCTAssertTrue(isLeapYear(2000))
        XCTAssertFalse(isLeapYear(1900))
    }

    func testInfo() {
        let rrule = RRule(.frequency(.yearly),
                          .count(3),
                          .dtStart(datetime(1997, 9, 2, 9, 0)))

        let (year, month, day, hour, minute, second) = rrule.dtStart!.tuple

        var info = IterInfo(rrule)
        info.rebuild(year: year, month: month)
    }

}
