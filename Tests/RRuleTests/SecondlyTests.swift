//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

@testable import RecurrenceKit
import XCTest

final class SecondlyTests: XCTestCase, RRuleTester {

    func testSecondly() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 0),
                datetime(1997, 9, 2, 9, 0, 1),
                datetime(1997, 9, 2, 9, 0, 2)
            ]
        )
    }

    func testSecondlyInterval() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                interval: 2,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 0),
                datetime(1997, 9, 2, 9, 0, 2),
                datetime(1997, 9, 2, 9, 0, 4)
            ]
        )
    }

    func testSecondlyIntervalLarge() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                interval: 90061,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 0),
                datetime(1997, 9, 3, 10, 1, 1),
                datetime(1997, 9, 4, 11, 2, 2)
            ]
        )
    }

    func testSecondlyByMonth() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.january, .march],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0, 0),
                datetime(1998, 1, 1, 0, 0, 1),
                datetime(1998, 1, 1, 0, 0, 2)
            ]
        )
    }

    func testSecondlyByMonthDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byDayOfMonth: [1, 3],
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 3, 0, 0, 0),
                datetime(1997, 9, 3, 0, 0, 1),
                datetime(1997, 9, 3, 0, 0, 2)
            ]
        )

    }

    func testSecondlyByMonthAndMonthDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.january, .march],
                byDayOfMonth: [5, 7],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 5, 0, 0, 0),
                datetime(1998, 1, 5, 0, 0, 1),
                datetime(1998, 1, 5, 0, 0, 2)
            ]
        )
    }

    func testSecondlyByWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byWeekday: [.tuesday, .thursday],
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 0),
                datetime(1997, 9, 2, 9, 0, 1),
                datetime(1997, 9, 2, 9, 0, 2)
            ]
        )
    }

    func testSecondlyByNWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byNWeekday: [
                    .init(1, .tuesday),
                    .init(-1, .thursday)
                ],
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 0),
                datetime(1997, 9, 2, 9, 0, 1),
                datetime(1997, 9, 2, 9, 0, 2)
            ]
        )
    }

    func testSecondlyByMonthAndWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.january, .march],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0, 0),
                datetime(1998, 1, 1, 0, 0, 1),
                datetime(1998, 1, 1, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByMonthAndNWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.january, .march],
                byNWeekday: [
                    .init(1, .tuesday),
                    .init(-1, .thursday)
                ],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0, 0),
                datetime(1998, 1, 1, 0, 0, 1),
                datetime(1998, 1, 1, 0, 0, 2)
            ]
        )
    }

    func testSecondlyByMonthDayAndWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byDayOfMonth: [1, 3],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0, 0),
                datetime(1998, 1, 1, 0, 0, 1),
                datetime(1998, 1, 1, 0, 0, 2)
            ]
        )
        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByMonthAndMonthDayAndWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.january, .march],
                byDayOfMonth: [1, 3],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 0, 0, 0),
                datetime(1998, 1, 1, 0, 0, 1),
                datetime(1998, 1, 1, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByYearDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byYearDay: [1, 100, 200, 365],
                count: 4
            ),
            toMatch: [
                datetime(1997, 12, 31, 0, 0, 0),
                datetime(1997, 12, 31, 0, 0, 1),
                datetime(1997, 12, 31, 0, 0, 2),
                datetime(1997, 12, 31, 0, 0, 3)
            ]
        )
    }

    func testSecondlyByYearDayNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byYearDay: [-365, -266, -166, -1],
                count: 4
            ),
            toMatch: [
                datetime(1997, 12, 31, 0, 0, 0),
                datetime(1997, 12, 31, 0, 0, 1),
                datetime(1997, 12, 31, 0, 0, 2),
                datetime(1997, 12, 31, 0, 0, 3)
            ]
        )
    }

    func testSecondlyByMonthAndYearDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.april, .july],
                byYearDay: [1, 100, 200, 365],
                count: 4
            ),
            toMatch: [
                datetime(1998, 4, 10, 0, 0, 0),
                datetime(1998, 4, 10, 0, 0, 1),
                datetime(1998, 4, 10, 0, 0, 2),
                datetime(1998, 4, 10, 0, 0, 3)
            ]
        )
    }

    func testSecondlyByMonthAndYearDayNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMonth: [.april, .july],
                byYearDay: [-365, -266, -166, -1],
                count: 4
            ),
            toMatch: [
                datetime(1998, 4, 10, 0, 0, 0),
                datetime(1998, 4, 10, 0, 0, 1),
                datetime(1998, 4, 10, 0, 0, 2),
                datetime(1998, 4, 10, 0, 0, 3)
            ]
        )
    }

    func testSecondlyByWeekNo() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 5, 11, 0, 0, 0),
                datetime(1998, 5, 11, 0, 0, 1),
                datetime(1998, 5, 11, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byweekno=20,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByWeekNoAndWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 29, 0, 0, 0),
                datetime(1997, 12, 29, 0, 0, 1),
                datetime(1997, 12, 29, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byweekno=1,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByWeekNoAndWeekDayLarge() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 28, 0, 0, 0),
                datetime(1997, 12, 28, 0, 0, 1),
                datetime(1997, 12, 28, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byweekno=52,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByWeekNoAndWeekDayLast() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 28, 0, 0, 0),
                datetime(1997, 12, 28, 0, 0, 1),
                datetime(1997, 12, 28, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byweekno=-1,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByWeekNoAndWeekDay53() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 12, 28, 0, 0, 0),
                datetime(1998, 12, 28, 0, 0, 1),
                datetime(1998, 12, 28, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byweekno=53,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByEaster() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 12, 0, 0, 0),
                datetime(1998, 4, 12, 0, 0, 1),
                datetime(1998, 4, 12, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byeaster=0,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByEasterPos() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 13, 0, 0, 0),
                datetime(1998, 4, 13, 0, 0, 1),
                datetime(1998, 4, 13, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byeaster=1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByEasterNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 11, 0, 0, 0),
                datetime(1998, 4, 11, 0, 0, 1),
                datetime(1998, 4, 11, 0, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byeaster=-1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByHour() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 0, 0),
                datetime(1997, 9, 2, 18, 0, 1),
                datetime(1997, 9, 2, 18, 0, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByMinute() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 6, 0),
                datetime(1997, 9, 2, 9, 6, 1),
                datetime(1997, 9, 2, 9, 6, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyBySecond() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 6),
                datetime(1997, 9, 2, 9, 0, 18),
                datetime(1997, 9, 2, 9, 1, 6)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByHourAndMinute() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 6, 0),
                datetime(1997, 9, 2, 18, 6, 1),
                datetime(1997, 9, 2, 18, 6, 2)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByHourAndSecond() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 0, 6),
                datetime(1997, 9, 2, 18, 0, 18),
                datetime(1997, 9, 2, 18, 1, 6)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByMinuteAndSecond() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 6, 6),
                datetime(1997, 9, 2, 9, 6, 18),
                datetime(1997, 9, 2, 9, 18, 6)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByHourAndMinuteAndSecond() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 6, 6),
                datetime(1997, 9, 2, 18, 6, 18),
                datetime(1997, 9, 2, 18, 18, 6)
            ]
        )

        //        self.assertEqual(list(rrule(SECONDLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),

    }

    func testSecondlyByHourAndMinuteAndSecondBug() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .secondly,
                byMinute: [1],
                bySecond: [0],
                count: 3
            ),
            toMatch: [
                datetime(2010, 3, 22, 12, 1),
                datetime(2010, 3, 22, 13, 1),
                datetime(2010, 3, 22, 14, 1)
            ]
        )
    }

}
