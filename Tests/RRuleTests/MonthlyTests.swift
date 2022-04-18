//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

@testable import RecurrenceKit
@testable import SnapshotTesting
import XCTest

func datetime(
    _ year: Int,
    _ month: Int,
    _ day: Int,
    _ hour: Int = 0,
    _ minute: Int = 0,
    _ second: Int = 0
) -> DateComponents {
    DateComponents(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second
    )
}

protocol RRuleTester { }

extension RRuleTester {

    func expect(
        _ rrule: RRule,
        toMatch expectation: [DateComponents],
        file _: StaticString = #file,
        testName _: String = #function,
        line _: UInt = #line
    ) {
        let context = EnumerationContext()
        let result = rrule
            .dateComponents(with: context)
            .asArray

        if result == expectation {
            return
        }

        let year = rrule.initialYear
        let calendar = year.calendar

        let date = calendar.date(from: result.first!)!
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        print(formatter.string(from: date))

        let r2 = result.map { components in
            year.day(for: components)
        }
        for r in r2 {
            print(r)
        }
        print("")

        let diff = SnapshotTesting
            .diff(result, expectation)
            .flatMap { difference -> [String] in
                let x = difference
                let ident: String
                switch x.which {
                    case .first:
                        ident = " + "
                    case .second:
                        ident = " - "
                    case .both:
                        ident = "   "
                }

                return x.elements.map {
                    "\(ident)\($0.serialized)"
                }
            }
            .joined(separator: "\n")

        let message = """
        result does not match expectation

        \(diff)
        """

        print(message)
        XCTFail(message)
    }

}

final class MonthlyTests: XCTestCase, RRuleTester {

    func testMonthly() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 10, 2, 9, 0),
                datetime(1997, 11, 2, 9, 0)
            ]
        )
    }

    func testMonthlyInterval() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                interval: 2,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 11, 2, 9, 0),
                datetime(1998, 1, 2, 9, 0)
            ]
        )
    }

    func testMonthlyIntervalLarge() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                interval: 18,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1999, 3, 2, 9, 0),
                datetime(2000, 9, 2, 9, 0)
            ]
        )
    }

    func testMonthlyByMonth() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byMonth: [.january, .march],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 2, 9, 0),
                datetime(1998, 3, 2, 9, 0),
                datetime(1999, 1, 2, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byDayOfMonth: [1, 3],
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 3, 9, 0),
                datetime(1997, 10, 1, 9, 0),
                datetime(1997, 10, 3, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndMonthDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byMonth: [.january, .march],
                byDayOfMonth: [5, 7],
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 5, 9, 0),
                datetime(1998, 1, 7, 9, 0),
                datetime(1998, 3, 5, 9, 0)
            ]
        )
    }

    func testMonthlyByWeekDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byWeekday: [.tuesday, .thursday],
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 4, 9, 0),
                datetime(1997, 9, 9, 9, 0)
            ]
        )
    }

    func testMonthlyByThirdMonday() {
        // # Third Monday of the month
        //        //        self.assertEqual(rrule(MONTHLY,
        //        byweekday=(MO(+3)),
        //        dtstart=datetime(1997, 9, 1)).between(datetime(1997, 9, 1),
        //   datetime(1997, 12, 1)),

        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 15, 0, 0),
                datetime(1997, 10, 20, 0, 0),
                datetime(1997, 11, 17, 0, 0)
            ]
        )
    }

    func testMonthlyByNWeekDay() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0),
                datetime(1997, 9, 25, 9, 0),
                datetime(1997, 10, 7, 9, 0)
            ]
        )
    }

    func testMonthlyByNWeekDayLarge() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekday=(TU(3), TH(-3)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 11, 9, 0),
                datetime(1997, 9, 16, 9, 0),
                datetime(1997, 10, 16, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndWeekDay() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 9, 0),
                datetime(1998, 1, 6, 9, 0),
                datetime(1998, 1, 8, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndNWeekDay() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 6, 9, 0),
                datetime(1998, 1, 29, 9, 0),
                datetime(1998, 3, 3, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndNWeekDayLarge() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU(3), TH(-3)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 15, 9, 0),
                datetime(1998, 1, 20, 9, 0),
                datetime(1998, 3, 12, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 9, 0),
                datetime(1998, 2, 3, 9, 0),
                datetime(1998, 3, 3, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 1, 1, 9, 0),
                datetime(1998, 3, 3, 9, 0),
                datetime(2001, 3, 1, 9, 0)
            ]
        )
    }

    func testMonthlyByYearDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byYearDay: [1, 100, 200, 365],
                count: 4
            ),
            toMatch: [
                datetime(1997, 12, 31, 9, 0),
                datetime(1998, 1, 1, 9, 0),
                datetime(1998, 4, 10, 9, 0),
                datetime(1998, 7, 19, 9, 0)
            ]
        )
    }

    func testMonthlyByYearDayNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byYearDay: [-365, -266, -166, -1],
                count: 4
            ),
            toMatch: [
                datetime(1997, 12, 31, 9, 0),
                datetime(1998, 1, 1, 9, 0),
                datetime(1998, 4, 10, 9, 0),
                datetime(1998, 7, 19, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndYearDay() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byMonth: [.april, .july],
                byYearDay: [1, 100, 200, 365],
                count: 4
            ),
            toMatch: [
                datetime(1998, 4, 10, 9, 0),
                datetime(1998, 7, 19, 9, 0),
                datetime(1999, 4, 10, 9, 0),
                datetime(1999, 7, 19, 9, 0)
            ]
        )
    }

    func testMonthlyByMonthAndYearDayNeg() {
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                byMonth: [.april, .july],
                byYearDay: [-365, -266, -166, -1],
                count: 4
            ),
            toMatch: [
                datetime(1998, 4, 10, 9, 0),
                datetime(1998, 7, 19, 9, 0),
                datetime(1999, 4, 10, 9, 0),
                datetime(1999, 7, 19, 9, 0)
            ]
        )
    }

    func testMonthlyByWeekNo() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekno=20,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 5, 11, 9, 0),
                datetime(1998, 5, 12, 9, 0),
                datetime(1998, 5, 13, 9, 0)
            ]
        )
    }

    func testMonthlyByWeekNoAndWeekDay() {
        //            # That's a nice one. The first days of week number one
        //            # may be in the last year.
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekno=1,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 29, 9, 0),
                datetime(1999, 1, 4, 9, 0),
                datetime(2000, 1, 3, 9, 0)
            ]
        )
    }

    func testMonthlyByWeekNoAndWeekDayLarge() {
        //            # Another nice test. The last days of week number 52/53
        //            # may be in the next year.
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekno=52,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 28, 9, 0),
                datetime(1998, 12, 27, 9, 0),
                datetime(2000, 1, 2, 9, 0)
            ]
        )
    }

    func testMonthlyByWeekNoAndWeekDayLast() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekno=-1,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 12, 28, 9, 0),
                datetime(1999, 1, 3, 9, 0),
                datetime(2000, 1, 2, 9, 0)
            ]
        )
    }

    func testMonthlyByWeekNoAndWeekDay53() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byweekno=53,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 12, 28, 9, 0),
                datetime(2004, 12, 27, 9, 0),
                datetime(2009, 12, 28, 9, 0)
            ]
        )
    }

    func testMonthlyByEaster() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byeaster=0,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 12, 9, 0),
                datetime(1999, 4, 4, 9, 0),
                datetime(2000, 4, 23, 9, 0)
            ]
        )
    }

    func testMonthlyByEasterPos() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byeaster=1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 13, 9, 0),
                datetime(1999, 4, 5, 9, 0),
                datetime(2000, 4, 24, 9, 0)
            ]
        )
    }

    func testMonthlyByEasterNeg() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byeaster=-1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1998, 4, 11, 9, 0),
                datetime(1999, 4, 3, 9, 0),
                datetime(2000, 4, 22, 9, 0)
            ]
        )
    }

    func testMonthlyByHour() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 0),
                datetime(1997, 10, 2, 6, 0),
                datetime(1997, 10, 2, 18, 0)
            ]
        )
    }

    func testMonthlyByMinute() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 6),
                datetime(1997, 9, 2, 9, 18),
                datetime(1997, 10, 2, 9, 6)
            ]
        )
    }

    func testMonthlyBySecond() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 0, 6),
                datetime(1997, 9, 2, 9, 0, 18),
                datetime(1997, 10, 2, 9, 0, 6)
            ]
        )
    }

    func testMonthlyByHourAndMinute() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 6),
                datetime(1997, 9, 2, 18, 18),
                datetime(1997, 10, 2, 6, 6)
            ]
        )
    }

    func testMonthlyByHourAndSecond() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 0, 6),
                datetime(1997, 9, 2, 18, 0, 18),
                datetime(1997, 10, 2, 6, 0, 6)
            ]
        )
    }

    func testMonthlyByMinuteAndSecond() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 9, 6, 6),
                datetime(1997, 9, 2, 9, 6, 18),
                datetime(1997, 9, 2, 9, 18, 6)
            ]
        )
    }

    func testMonthlyByHourAndMinuteAndSecond() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 2, 18, 6, 6),
                datetime(1997, 9, 2, 18, 6, 18),
                datetime(1997, 9, 2, 18, 18, 6)
            ]
        )
    }

    func testMonthlyBySetPos() {
        //        self.assertEqual(list(rrule(MONTHLY,
        //                              count=3,
        //                              bymonthday=(13, 17),
        //                              byhour=(6, 18),
        //                              bysetpos=(3, -3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(
            RRule(
                starting: datetime(1997, 9, 2, 9, 0),
                frequency: .monthly,
                count: 3
            ),
            toMatch: [
                datetime(1997, 9, 13, 18, 0),
                datetime(1997, 9, 17, 6, 0),
                datetime(1997, 10, 13, 18, 0)
            ]
        )
    }

}
