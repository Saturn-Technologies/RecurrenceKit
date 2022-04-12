//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

@testable import RecurrenceKit
import XCTest

final class YearlyTests: XCTestCase, RRuleTester {

    func testYearly() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1998, 9, 2, 9, 0),
                   datetime(1999, 9, 2, 9, 0)
               ])
    }

    func testYearlyInterval() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     interval: 2,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1999, 9, 2, 9, 0),
                   datetime(2001, 9, 2, 9, 0)
               ])
    }

    func testYearlyIntervalLarge() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     interval: 100,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(2097, 9, 2, 9, 0),
                   datetime(2197, 9, 2, 9, 0)
               ])
    }

    func testYearlyByMonth() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.january, .march],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 2, 9, 0),
                   datetime(1998, 3, 2, 9, 0),
                   datetime(1999, 1, 2, 9, 0)
               ])
    }

    func testYearlyByMonthDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byDayOfMonth: [1, 3],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 3, 9, 0),
                   datetime(1997, 10, 1, 9, 0),
                   datetime(1997, 10, 3, 9, 0)
               ])
    }

    func testYearlyByMonthAndMonthDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.january, .march],
                     byDayOfMonth: [5, 7],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 5, 9, 0),
                   datetime(1998, 1, 7, 9, 0),
                   datetime(1998, 3, 5, 9, 0)
               ])
    }

    func testYearlyByWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 4, 9, 0),
                   datetime(1997, 9, 9, 9, 0)
               ])
    }

    func testYearlyByNWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byNWeekday: [.init(1, .tuesday),
                                  .init(-1, .thursday)],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 25, 9, 0),
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 12, 31, 9, 0)
               ])
    }

    func testYearlyByNWeekDayLarge() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byNWeekday: [.init(3, .tuesday),
                                  .init(-3, .thursday)],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 11, 9, 0),
                   datetime(1998, 1, 20, 9, 0),
                   datetime(1998, 12, 17, 9, 0)
               ])
    }

    func testYearlyByMonthAndWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.january, .march],
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 8, 9, 0)
               ])
    }

    func testYearlyByMonthAndNWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.january, .march],
                     byNWeekday: [.init(1, .tuesday),
                                  .init(-1, .thursday)],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 29, 9, 0),
                   datetime(1998, 3, 3, 9, 0)
               ])
    }

    func testYearlyByMonthAndNWeekDayLarge() {
        // This is interesting because the TH(-3) ends up before
        // the TU(3).
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.january, .march],
                     byNWeekday: [.init(3, .tuesday),
                                  .init(-3, .thursday)],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 15, 9, 0),
                   datetime(1998, 1, 20, 9, 0),
                   datetime(1998, 3, 12, 9, 0)
               ])
    }

    func testYearlyByMonthDayAndWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byDayOfMonth: [1, 3],
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 2, 3, 9, 0),
                   datetime(1998, 3, 3, 9, 0)
               ])
    }

    func testYearlyByMonthAndMonthDayAndWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.january, .march],
                     byDayOfMonth: [1, 3],
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 3, 3, 9, 0),
                   datetime(2001, 3, 1, 9, 0)
               ])
    }

    func testYearlyByYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 9, 0),
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0)
               ])
    }

    func testYearlyByYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 9, 0),
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0)
               ])
    }

    func testYearlyByMonthAndYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.april, .july],
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0),
                   datetime(1999, 4, 10, 9, 0),
                   datetime(1999, 7, 19, 9, 0)
               ])
    }

    func testYearlyByMonthAndYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMonth: [.april, .july],
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0),
                   datetime(1999, 4, 10, 9, 0),
                   datetime(1999, 7, 19, 9, 0)
               ])
    }

    func testYearlyByWeekNo() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byWeekNo: [20],
                     count: 3),
               toMatch: [
                   datetime(1998, 5, 11, 9, 0),
                   datetime(1998, 5, 12, 9, 0),
                   datetime(1998, 5, 13, 9, 0)
               ])
    }

    func testYearlyByWeekNoAndWeekDay() {
        // That's a nice one. The first days of week number one
        // may be in the last year.

        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byWeekday: [.monday],
                     byWeekNo: [1],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 29, 9, 0),
                   datetime(1999, 1, 4, 9, 0),
                   datetime(2000, 1, 3, 9, 0)
               ])
    }

    func testYearlyByWeekNoAndWeekDayLarge() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byWeekday: [.sunday],
                     byWeekNo: [52],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 9, 0),
                   datetime(1998, 12, 27, 9, 0),
                   datetime(2000, 1, 2, 9, 0)
               ])
    }

    func testYearlyByWeekNoAndWeekDayLast() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byWeekday: [.sunday],
                     byWeekNo: [-1],
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 9, 0),
                   datetime(1999, 1, 3, 9, 0),
                   datetime(2000, 1, 2, 9, 0)
               ])
    }

//    func testYearlyByEaster() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .yearly,
//                 //  byEaster: 0,
//                     count: 3),
//               toMatch: [
//                   datetime(1998, 4, 12, 9, 0),
//                   datetime(1999, 4, 4, 9, 0),
//                   datetime(2000, 4, 23, 9, 0)
//               ])
//    }

//    func testYearlyByEasterPos() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .yearly,
//                 //  byEaster: 1,
//                     count: 3),
//               toMatch: [
//                   datetime(1998, 4, 13, 9, 0),
//                   datetime(1999, 4, 5, 9, 0),
//                   datetime(2000, 4, 24, 9, 0)
//               ])
//    }

//    func testYearlyByEasterNeg() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .yearly,
//                 //  byEaster: -1,
//                     count: 3),
//               toMatch: [
//                   datetime(1998, 4, 11, 9, 0),
//                   datetime(1999, 4, 3, 9, 0),
//                   datetime(2000, 4, 22, 9, 0)
//               ])
//    }

    func testYearlyByWeekNoAndWeekDay53() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byWeekday: [.monday],
                     byWeekNo: [53],
                     count: 3),
               toMatch: [
                   datetime(1998, 12, 28, 9, 0),
                   datetime(2004, 12, 27, 9, 0),
                   datetime(2009, 12, 28, 9, 0)
               ])
    }

    func testYearlyByHour() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byHour: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0),
                   datetime(1998, 9, 2, 6, 0),
                   datetime(1998, 9, 2, 18, 0)
               ])
    }

    func testYearlyByMinute() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMinute: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6),
                   datetime(1997, 9, 2, 9, 18),
                   datetime(1998, 9, 2, 9, 6)
               ])
    }

    func testYearlyBySecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0, 6),
                   datetime(1997, 9, 2, 9, 0, 18),
                   datetime(1998, 9, 2, 9, 0, 6)
               ])
    }

    func testYearlyByHourAndMinute() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byHour: [6, 18],
                     byMinute: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6),
                   datetime(1997, 9, 2, 18, 18),
                   datetime(1998, 9, 2, 6, 6)
               ])
    }

    func testYearlyByHourAndSecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byHour: [6, 18],
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0, 6),
                   datetime(1997, 9, 2, 18, 0, 18),
                   datetime(1998, 9, 2, 6, 0, 6)
               ])
    }

    func testYearlyByMinuteAndSecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
                     byMinute: [6, 18],
                     bySecond: [6, 18],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6, 6),
                   datetime(1997, 9, 2, 9, 6, 18),
                   datetime(1997, 9, 2, 9, 18, 6)
               ])
    }

    func testYearlyByHourAndMinuteAndSecond() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .yearly,
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

//    func testYearlyBySetPos() {
//        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
//                     frequency: .yearly,
//                     byDayOfMonth: [15],
//                     //  byHour: [6, 18],
//                     //  bySetPos: [3, -3],
//                     count: 3),
//               toMatch: [
//                   datetime(1997, 11, 15, 18, 0),
//                   datetime(1998, 2, 15, 6, 0),
//                   datetime(1998, 11, 15, 18, 0)
//               ])
//    }

}
