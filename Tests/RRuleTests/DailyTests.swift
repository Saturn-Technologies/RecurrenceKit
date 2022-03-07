//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

@testable import RRule
import XCTest

final class DailyTests: XCTestCase, RRuleTester {

    func testDaily() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 3, 9, 0),
                   datetime(1997, 9, 4, 9, 0)
               ])
    }

    func testDailyInterval() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     interval: 2,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 4, 9, 0),
                   datetime(1997, 9, 6, 9, 0)
               ])
    }

    func testDailyIntervalLarge() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     interval: 92,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 12, 3, 9, 0),
                   datetime(1998, 3, 5, 9, 0)
               ])
    }

    func testDailyByMonth() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byMonth: [.january, .march],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 1, 2, 9, 0),
                   datetime(1998, 1, 3, 9, 0)
               ])
    }

    func testDailyByMonthDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byDayOfMonth: [1, 3],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 3, 9, 0),
                   datetime(1997, 10, 1, 9, 0),
                   datetime(1997, 10, 3, 9, 0)
               ])
    }

    func testDailyByMonthAndMonthDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byMonth: [.january, .march],
                     byDayOfMonth: [5, 7],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 5, 9, 0),
                   datetime(1998, 1, 7, 9, 0),
                   datetime(1998, 3, 5, 9, 0)
               ])
    }

    func testDailyByWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 4, 9, 0),
                   datetime(1997, 9, 9, 9, 0)
               ])
    }

    func testDailyByNWeekDay() {
        //        self.assertEqual(list(rrule(DAILY,
        //                              count=3,
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 4, 9, 0),
                   datetime(1997, 9, 9, 9, 0)
               ])
    }

    func testDailyByMonthAndWeekDay() {
        //        self.assertEqual(list(rrule(DAILY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 8, 9, 0)
               ])
    }

    func testDailyByMonthAndNWeekDay() {
        //        self.assertEqual(list(rrule(DAILY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 8, 9, 0)
               ])
    }

    func testDailyByMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(DAILY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 2, 3, 9, 0),
                   datetime(1998, 3, 3, 9, 0)
               ])
    }

    func testDailyByMonthAndMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(DAILY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 3, 3, 9, 0),
                   datetime(2001, 3, 1, 9, 0)
               ])
    }

    func testDailyByYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 9, 0),
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0)
               ])
    }

    func testDailyByYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 9, 0),
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0)
               ])
    }

    func testDailyByMonthAndYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byMonth: [.january, .july],
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 7, 19, 9, 0),
                   datetime(1999, 1, 1, 9, 0),
                   datetime(1999, 7, 19, 9, 0)
               ])
    }

    func testDailyByMonthAndYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byMonth: [.january, .july],
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 7, 19, 9, 0),
                   datetime(1999, 1, 1, 9, 0),
                   datetime(1999, 7, 19, 9, 0)
               ])
    }

    func testDailyByWeekNo() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byWeekNo: [20],
                     count: 3),
               toMatch: [
                   datetime(1998, 5, 11, 9, 0),
                   datetime(1998, 5, 12, 9, 0),
                   datetime(1998, 5, 13, 9, 0)
               ])
    }

    func testDailyByWeekNoAndWeekDay() {
        // That's a nice one. The first days of week number one
        // may be in the last year.
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byWeekday: [.monday],
                     byWeekNo: [1],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 29, 9, 0),
                   datetime(1999, 1, 4, 9, 0),
                   datetime(2000, 1, 3, 9, 0)
               ])
    }

    func testDailyByWeekNoAndWeekDayLarge() {
        // Another nice test. The last days of week number 52/53
        // may be in the next year.
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byWeekday: [.sunday],
                     byWeekNo: [52],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 9, 0),
                   datetime(1998, 12, 27, 9, 0),
                   datetime(2000, 1, 2, 9, 0)
               ])
    }

    func testDailyByWeekNoAndWeekDayLast() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byWeekday: [.sunday],
                     byWeekNo: [-1],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 9, 0),
                   datetime(1999, 1, 3, 9, 0),
                   datetime(2000, 1, 2, 9, 0)
               ])
    }

    func testDailyByWeekNoAndWeekDay53() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byWeekday: [.monday],
                     byWeekNo: [53],
                     count: 3),
               toMatch: [
                   datetime(1998, 12, 28, 9, 0),
                   datetime(2004, 12, 27, 9, 0),
                   datetime(2009, 12, 28, 9, 0)
               ])
    }

//    func testDailyByEaster() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .daily,
//                     byEaster: [0],
//                     count: 3),
//               toMatch: [
//                   datetime(1998, 4, 12, 9, 0),
//                   datetime(1999, 4, 4, 9, 0),
//                   datetime(2000, 4, 23, 9, 0)
//               ])
//    }

//    func testDailyByEasterPos() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .daily,
//                     byEaster: 1,
//                     count: 3),
//               toMatch: [
//                   datetime(1998, 4, 13, 9, 0),
//                   datetime(1999, 4, 5, 9, 0),
//                   datetime(2000, 4, 24, 9, 0)
//               ])
//    }

//    func testDailyByEasterNeg() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .daily,
//                     byEaster: -1,
//                     count: 3),
//               toMatch: [
//                   datetime(1998, 4, 11, 9, 0),
//                   datetime(1999, 4, 3, 9, 0),
//                   datetime(2000, 4, 22, 9, 0)
//               ])
//    }

    func testDailyByHour() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byHour: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0),
                   datetime(1997, 9, 3, 6, 0),
                   datetime(1997, 9, 3, 18, 0)
               ])
    }

    func testDailyByMinute() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byMinute: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6),
                   datetime(1997, 9, 2, 9, 18),
                   datetime(1997, 9, 3, 9, 6)
               ])
    }

    func testDailyBySecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0, 6),
                   datetime(1997, 9, 2, 9, 0, 18),
                   datetime(1997, 9, 3, 9, 0, 6)
               ])
    }

    func testDailyByHourAndMinute() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byHour: [6, 18],
                     byMinute: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6),
                   datetime(1997, 9, 2, 18, 18),
                   datetime(1997, 9, 3, 6, 6)
               ])
    }

    func testDailyByHourAndSecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byHour: [6, 18],
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0, 6),
                   datetime(1997, 9, 2, 18, 0, 18),
                   datetime(1997, 9, 3, 6, 0, 6)
               ])
    }

    func testDailyByMinuteAndSecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byMinute: [6, 18],
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6, 6),
                   datetime(1997, 9, 2, 9, 6, 18),
                   datetime(1997, 9, 2, 9, 18, 6)
               ])
    }

    func testDailyByHourAndMinuteAndSecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .daily,
                     byHour: [6, 18],
                     byMinute: [6, 18],
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6, 6),
                   datetime(1997, 9, 2, 18, 6, 18),
                   datetime(1997, 9, 2, 18, 18, 6)
               ])
    }

//    func testDailyBySetPos() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .daily,
//                     byHour: [6, 18],
//                     byMinute: [15, 45],
//                     bySetPos: [3, -3],
//                     count: 3),
//               toMatch: [
//                   datetime(1997, 9, 2, 18, 15),
//                   datetime(1997, 9, 3, 6, 45),
//                   datetime(1997, 9, 3, 18, 15)
//               ])
//    }

}
