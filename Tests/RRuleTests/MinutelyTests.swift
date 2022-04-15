//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

@testable import RecurrenceKit
import XCTest

final class MinutelyTests: XCTestCase, RRuleTester {

    func testMinutely() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 2, 9, 1),
                datetime(1997, 9, 2, 9, 2)
            ]
        )
    }

    func testMinutelyInterval() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              interval=2,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 2, 9, 2),
                datetime(1997, 9, 2, 9, 4)
            ]
        )
    }

    func testMinutelyIntervalLarge() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              interval=1501,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 3, 10, 1),
                datetime(1997, 9, 4, 11, 2)
            ]
        )
    }

    func testMinutelyByMonth() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0),
                datetime(1998, 1, 1, 0, 1),
                datetime(1998, 1, 1, 0, 2)
            ]
        )
    }

    func testMinutelyByMonthDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 3, 0, 0),
                datetime(1997, 9, 3, 0, 1),
                datetime(1997, 9, 3, 0, 2)
            ]
        )
    }

    func testMinutelyByMonthAndMonthDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(5, 7),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 5, 0, 0),
                datetime(1998, 1, 5, 0, 1),
                datetime(1998, 1, 5, 0, 2)
            ]
        )
    }

    func testMinutelyByWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 2, 9, 1),
                datetime(1997, 9, 2, 9, 2)
            ]
        )
    }

    func testMinutelyByNWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 2, 9, 1),
                datetime(1997, 9, 2, 9, 2)
            ]
        )
    }

    func testMinutelyByMonthAndWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0),
                datetime(1998, 1, 1, 0, 1),
                datetime(1998, 1, 1, 0, 2)
            ]
        )
    }

    func testMinutelyByMonthAndNWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0),
                datetime(1998, 1, 1, 0, 1),
                datetime(1998, 1, 1, 0, 2)
            ]
        )
    }

    func testMinutelyByMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0),
                datetime(1998, 1, 1, 0, 1),
                datetime(1998, 1, 1, 0, 2)
            ]
        )
    }

    func testMinutelyByMonthAndMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0),
                datetime(1998, 1, 1, 0, 1),
                datetime(1998, 1, 1, 0, 2)
            ]
        )
    }

    func testMinutelyByYearDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                byYearDay: [1, 100, 200, 365],
                count: 4
            ),
            toMatch: [
                datetime(1997, 12, 31, 0, 0),
                datetime(1997, 12, 31, 0, 1),
                datetime(1997, 12, 31, 0, 2),
                datetime(1997, 12, 31, 0, 3)
            ]
        )
    }

    func testMinutelyByYearDayNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                byYearDay: [-365, -266, -166, -1],
                count: 4
            ),
            toMatch: [
                datetime(1997, 12, 31, 0, 0),
                datetime(1997, 12, 31, 0, 1),
                datetime(1997, 12, 31, 0, 2),
                datetime(1997, 12, 31, 0, 3)
            ]
        )
    }

    func testMinutelyByMonthAndYearDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                byMonth: [.april, .july],
                byYearDay: [1, 100, 200, 365],
                count: 4
            ),
            toMatch: [
                datetime(1998, 4, 10, 0, 0),
                datetime(1998, 4, 10, 0, 1),
                datetime(1998, 4, 10, 0, 2),
                datetime(1998, 4, 10, 0, 3)
            ]
        )
    }

    func testMinutelyByMonthAndYearDayNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                byMonth: [.april, .july],
                byYearDay: [-365, -266, -166, -1],
                count: 4
            ),
            toMatch: [
                datetime(1998, 4, 10, 0, 0),
                datetime(1998, 4, 10, 0, 1),
                datetime(1998, 4, 10, 0, 2),
                datetime(1998, 4, 10, 0, 3)
            ]
        )
    }

    func testMinutelyByWeekNo() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekno=20,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 5, 11, 0, 0),
                datetime(1998, 5, 11, 0, 1),
                datetime(1998, 5, 11, 0, 2)
            ]
        )
    }

    func testMinutelyByWeekNoAndWeekDay() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekno=1,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 29, 0, 0),
                datetime(1997, 12, 29, 0, 1),
                datetime(1997, 12, 29, 0, 2)
            ]
        )
    }

    func testMinutelyByWeekNoAndWeekDayLarge() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekno=52,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 28, 0, 0),
                datetime(1997, 12, 28, 0, 1),
                datetime(1997, 12, 28, 0, 2)
            ]
        )
    }

    func testMinutelyByWeekNoAndWeekDayLast() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekno=-1,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 28, 0, 0),
                datetime(1997, 12, 28, 0, 1),
                datetime(1997, 12, 28, 0, 2)
            ]
        )
    }

    func testMinutelyByWeekNoAndWeekDay53() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byweekno=53,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 12, 28, 0, 0),
                datetime(1998, 12, 28, 0, 1),
                datetime(1998, 12, 28, 0, 2)
            ]
        )
    }

    func testMinutelyByEaster() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byeaster=0,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 12, 0, 0),
                datetime(1998, 4, 12, 0, 1),
                datetime(1998, 4, 12, 0, 2)
            ]
        )
    }

    func testMinutelyByEasterPos() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byeaster=1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 13, 0, 0),
                datetime(1998, 4, 13, 0, 1),
                datetime(1998, 4, 13, 0, 2)
            ]
        )
    }

    func testMinutelyByEasterNeg() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byeaster=-1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 11, 0, 0),
                datetime(1998, 4, 11, 0, 1),
                datetime(1998, 4, 11, 0, 2)
            ]
        )
    }

    func testMinutelyByHour() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 0),
                datetime(1997, 9, 2, 18, 1),
                datetime(1997, 9, 2, 18, 2)
            ]
        )
    }

    func testMinutelyByMinute() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 6),
                datetime(1997, 9, 2, 9, 18),
                datetime(1997, 9, 2, 10, 6)
            ]
        )
    }

    func testMinutelyBySecond() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 6),
                datetime(1997, 9, 2, 9, 0, 18),
                datetime(1997, 9, 2, 9, 1, 6)
            ]
        )
    }

    func testMinutelyByHourAndMinute() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 6),
                datetime(1997, 9, 2, 18, 18),
                datetime(1997, 9, 3, 6, 6)
            ]
        )
    }

    func testMinutelyByHourAndSecond() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 0, 6),
                datetime(1997, 9, 2, 18, 0, 18),
                datetime(1997, 9, 2, 18, 1, 6)
            ]
        )
    }

    func testMinutelyByMinuteAndSecond() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 6, 6),
                datetime(1997, 9, 2, 9, 6, 18),
                datetime(1997, 9, 2, 9, 18, 6)
            ]
        )
    }

    func testMinutelyByHourAndMinuteAndSecond() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 6, 6),
                datetime(1997, 9, 2, 18, 6, 18),
                datetime(1997, 9, 2, 18, 18, 6)
            ]
        )
    }

    func testMinutelyBySetPos() {
        //        self.assertEqual(list(rrule(MINUTELY,
        //                              count=3,
        //                              bysecond=(15, 30, 45),
        //                              bysetpos=(3, -3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .minutely,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 15),
                datetime(1997, 9, 2, 9, 0, 45),
                datetime(1997, 9, 2, 9, 1, 15)
            ]
        )
    }

}
