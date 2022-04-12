//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

@testable import RecurrenceKit
import XCTest

final class WeeklyTests: XCTestCase, RRuleTester {

    func testWeekly() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 9, 9, 0),
                   datetime(1997, 9, 16, 9, 0)
               ])
    }

    func testWeeklyAllDays() {
        for day in 1 ... 8 {
            expect(RRule(starting: datetime(1997, 9, day, 9, 0),
                         frequency: .weekly,
                         count: 3),
                   toMatch: [
                       datetime(1997, 9, day + 0, 9, 0),
                       datetime(1997, 9, day + 7, 9, 0),
                       datetime(1997, 9, day + 14, 9, 0)
                   ])
        }
    }

    func testWeeklyInterval() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     interval: 2,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 16, 9, 0),
                   datetime(1997, 9, 30, 9, 0)
               ])
    }

    func testWeeklyIntervalLarge() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     interval: 20,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1998, 1, 20, 9, 0),
                   datetime(1998, 6, 9, 9, 0)
               ])
    }

    func testWeeklyByMonth() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byMonth: [.january, .march],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 13, 9, 0),
                   datetime(1998, 1, 20, 9, 0)
               ])
    }

    func testWeeklyByMonthDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byDayOfMonth: [1, 3],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 3, 9, 0),
                   datetime(1997, 10, 1, 9, 0),
                   datetime(1997, 10, 3, 9, 0)
               ])
    }

    func testWeeklyByMonthAndMonthDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byMonth: [.january, .march],
                     byDayOfMonth: [5, 7],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 5, 9, 0),
                   datetime(1998, 1, 7, 9, 0),
                   datetime(1998, 3, 5, 9, 0)
               ])
    }

    func testWeeklyByWeekDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 4, 9, 0),
                   datetime(1997, 9, 9, 9, 0)
               ])
    }

    func testWeeklyByNWeekDay() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byNWeekday: [.init(3, .tuesday),
                                  .init(-3, .thursday)],
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 4, 9, 0),
                   datetime(1997, 9, 9, 9, 0)
               ])
    }

    func testWeeklyByMonthAndWeekDay() {
        //        # This test is interesting, because it crosses the year
        //        # boundary in a weekly period to find day '1' as a
        //        # valid recurrence.
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byMonth: [.january, .march],
                     byWeekday: [.tuesday, .thursday],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 8, 9, 0)
               ])
    }

    func testWeeklyByMonthAndNWeekDay() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byMonth: [.january, .march],
                     byNWeekday: [.init(3, .tuesday),
                                  .init(-3, .thursday)],
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 1, 6, 9, 0),
                   datetime(1998, 1, 8, 9, 0)
               ])
    }

    func testWeeklyByMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 2, 3, 9, 0),
                   datetime(1998, 3, 3, 9, 0)
               ])
    }

    func testWeeklyByMonthAndMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 3, 3, 9, 0),
                   datetime(2001, 3, 1, 9, 0)
               ])
    }

    func testWeeklyByYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 9, 0),
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0)
               ])
    }

    func testWeeklyByYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 9, 0),
                   datetime(1998, 1, 1, 9, 0),
                   datetime(1998, 4, 10, 9, 0),
                   datetime(1998, 7, 19, 9, 0)
               ])
    }

    func testWeeklyByMonthAndYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
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

    func testWeeklyByMonthAndYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
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

    func testWeeklyByWeekNo() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekno=20,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 5, 11, 9, 0),
                   datetime(1998, 5, 12, 9, 0),
                   datetime(1998, 5, 13, 9, 0)
               ])
    }

    func testWeeklyByWeekNoAndWeekDay() {
        //        # That's a nice one. The first days of week number one
        //        # may be in the last year.
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekno=1,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 29, 9, 0),
                   datetime(1999, 1, 4, 9, 0),
                   datetime(2000, 1, 3, 9, 0)
               ])
    }

    func testWeeklyByWeekNoAndWeekDayLarge() {
        //        # Another nice test. The last days of week number 52/53
        //        # may be in the next year.
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekno=52,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 9, 0),
                   datetime(1998, 12, 27, 9, 0),
                   datetime(2000, 1, 2, 9, 0)
               ])
    }

    func testWeeklyByWeekNoAndWeekDayLast() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekno=-1,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 9, 0),
                   datetime(1999, 1, 3, 9, 0),
                   datetime(2000, 1, 2, 9, 0)
               ])
    }

    func testWeeklyByWeekNoAndWeekDay53() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekno=53,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 12, 28, 9, 0),
                   datetime(2004, 12, 27, 9, 0),
                   datetime(2009, 12, 28, 9, 0)
               ])
    }

    func testWeeklyByEaster() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byeaster=0,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 4, 12, 9, 0),
                   datetime(1999, 4, 4, 9, 0),
                   datetime(2000, 4, 23, 9, 0)
               ])
    }

    func testWeeklyByEasterPos() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byeaster=1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 4, 13, 9, 0),
                   datetime(1999, 4, 5, 9, 0),
                   datetime(2000, 4, 24, 9, 0)
               ])
    }

    func testWeeklyByEasterNeg() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byeaster=-1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1998, 4, 11, 9, 0),
                   datetime(1999, 4, 3, 9, 0),
                   datetime(2000, 4, 22, 9, 0)
               ])
    }

    func testWeeklyByHour() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0),
                   datetime(1997, 9, 9, 6, 0),
                   datetime(1997, 9, 9, 18, 0)
               ])
    }

    func testWeeklyByMinute() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6),
                   datetime(1997, 9, 2, 9, 18),
                   datetime(1997, 9, 9, 9, 6)
               ])
    }

    func testWeeklyBySecond() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0, 6),
                   datetime(1997, 9, 2, 9, 0, 18),
                   datetime(1997, 9, 9, 9, 0, 6)
               ])
    }

    func testWeeklyByHourAndMinute() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6),
                   datetime(1997, 9, 2, 18, 18),
                   datetime(1997, 9, 9, 6, 6)
               ])
    }

    func testWeeklyByHourAndSecond() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0, 6),
                   datetime(1997, 9, 2, 18, 0, 18),
                   datetime(1997, 9, 9, 6, 0, 6)
               ])
    }

    func testWeeklyByMinuteAndSecond() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6, 6),
                   datetime(1997, 9, 2, 9, 6, 18),
                   datetime(1997, 9, 2, 9, 18, 6)
               ])
    }

    func testWeeklyByHourAndMinuteAndSecond() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6, 6),
                   datetime(1997, 9, 2, 18, 6, 18),
                   datetime(1997, 9, 2, 18, 18, 6)
               ])
    }

    func testWeeklyBySetPos() {
        //        self.assertEqual(list(rrule(WEEKLY,
        //                              count=3,
        //                              byweekday=(TU, TH),
        //                              byhour=(6, 18),
        //                              bysetpos=(3, -3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .weekly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0),
                   datetime(1997, 9, 4, 6, 0),
                   datetime(1997, 9, 9, 18, 0)
               ])
    }

}
