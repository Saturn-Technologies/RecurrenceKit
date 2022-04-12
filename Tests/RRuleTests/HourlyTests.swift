//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

@testable import RecurrenceKit
import XCTest

final class HourlyTests: XCTestCase, RRuleTester {

    func testHourly() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 2, 10, 0),
                   datetime(1997, 9, 2, 11, 0)
               ])
    }

    func testHourlyInterval() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              interval=2,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 2, 11, 0),
                   datetime(1997, 9, 2, 13, 0)
               ])
    }

    func testHourlyIntervalLarge() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              interval=769,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 10, 4, 10, 0),
                   datetime(1997, 11, 5, 11, 0)
               ])
    }

    func testHourlyByMonth() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 0, 0),
                   datetime(1998, 1, 1, 1, 0),
                   datetime(1998, 1, 1, 2, 0)
               ])
    }

    func testHourlyByMonthDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 3, 0, 0),
                   datetime(1997, 9, 3, 1, 0),
                   datetime(1997, 9, 3, 2, 0)
               ])
    }

    func testHourlyByMonthAndMonthDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(5, 7),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 5, 0, 0),
                   datetime(1998, 1, 5, 1, 0),
                   datetime(1998, 1, 5, 2, 0)
               ])
    }

    func testHourlyByWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 2, 10, 0),
                   datetime(1997, 9, 2, 11, 0)
               ])
    }

    func testHourlyByNWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0),
                   datetime(1997, 9, 2, 10, 0),
                   datetime(1997, 9, 2, 11, 0)
               ])
    }

    func testHourlyByMonthAndWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 0, 0),
                   datetime(1998, 1, 1, 1, 0),
                   datetime(1998, 1, 1, 2, 0)
               ])
    }

    func testHourlyByMonthAndNWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              byweekday=(TU(1), TH(-1)),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 0, 0),
                   datetime(1998, 1, 1, 1, 0),
                   datetime(1998, 1, 1, 2, 0)
               ])
    }

    func testHourlyByMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 0, 0),
                   datetime(1998, 1, 1, 1, 0),
                   datetime(1998, 1, 1, 2, 0)
               ])
    }

    func testHourlyByMonthAndMonthDayAndWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bymonth=(1, 3),
        //                              bymonthday=(1, 3),
        //                              byweekday=(TU, TH),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 1, 1, 0, 0),
                   datetime(1998, 1, 1, 1, 0),
                   datetime(1998, 1, 1, 2, 0)
               ])
    }

    func testHourlyByYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 0, 0),
                   datetime(1997, 12, 31, 1, 0),
                   datetime(1997, 12, 31, 2, 0),
                   datetime(1997, 12, 31, 3, 0)
               ])
    }

    func testHourlyByYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1997, 12, 31, 0, 0),
                   datetime(1997, 12, 31, 1, 0),
                   datetime(1997, 12, 31, 2, 0),
                   datetime(1997, 12, 31, 3, 0)
               ])
    }

    func testHourlyByMonthAndYearDay() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     byMonth: [.april, .july],
                     byYearDay: [1, 100, 200, 365],
                     count: 4),
               toMatch: [
                   datetime(1998, 4, 10, 0, 0),
                   datetime(1998, 4, 10, 1, 0),
                   datetime(1998, 4, 10, 2, 0),
                   datetime(1998, 4, 10, 3, 0)
               ])
    }

    func testHourlyByMonthAndYearDayNeg() {
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     byMonth: [.april, .july],
                     byYearDay: [-365, -266, -166, -1],
                     count: 4),
               toMatch: [
                   datetime(1998, 4, 10, 0, 0),
                   datetime(1998, 4, 10, 1, 0),
                   datetime(1998, 4, 10, 2, 0),
                   datetime(1998, 4, 10, 3, 0)
               ])
    }

    func testHourlyByWeekNo() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekno=20,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 5, 11, 0, 0),
                   datetime(1998, 5, 11, 1, 0),
                   datetime(1998, 5, 11, 2, 0)
               ])
    }

    func testHourlyByWeekNoAndWeekDay() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekno=1,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 29, 0, 0),
                   datetime(1997, 12, 29, 1, 0),
                   datetime(1997, 12, 29, 2, 0)
               ])
    }

    func testHourlyByWeekNoAndWeekDayLarge() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekno=52,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 0, 0),
                   datetime(1997, 12, 28, 1, 0),
                   datetime(1997, 12, 28, 2, 0)
               ])
    }

    func testHourlyByWeekNoAndWeekDayLast() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekno=-1,
        //                              byweekday=SU,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 12, 28, 0, 0),
                   datetime(1997, 12, 28, 1, 0),
                   datetime(1997, 12, 28, 2, 0)
               ])
    }

    func testHourlyByWeekNoAndWeekDay53() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byweekno=53,
        //                              byweekday=MO,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 12, 28, 0, 0),
                   datetime(1998, 12, 28, 1, 0),
                   datetime(1998, 12, 28, 2, 0)
               ])
    }

    func testHourlyByEaster() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byeaster=0,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 4, 12, 0, 0),
                   datetime(1998, 4, 12, 1, 0),
                   datetime(1998, 4, 12, 2, 0)
               ])
    }

    func testHourlyByEasterPos() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byeaster=1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 4, 13, 0, 0),
                   datetime(1998, 4, 13, 1, 0),
                   datetime(1998, 4, 13, 2, 0)
               ])
    }

    func testHourlyByEasterNeg() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byeaster=-1,
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1998, 4, 11, 0, 0),
                   datetime(1998, 4, 11, 1, 0),
                   datetime(1998, 4, 11, 2, 0)
               ])
    }

    func testHourlyByHour() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0),
                   datetime(1997, 9, 3, 6, 0),
                   datetime(1997, 9, 3, 18, 0)
               ])
    }

    func testHourlyByMinute() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6),
                   datetime(1997, 9, 2, 9, 18),
                   datetime(1997, 9, 2, 10, 6)
               ])
    }

    func testHourlyBySecond() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 0, 6),
                   datetime(1997, 9, 2, 9, 0, 18),
                   datetime(1997, 9, 2, 10, 0, 6)
               ])
    }

    func testHourlyByHourAndMinute() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6),
                   datetime(1997, 9, 2, 18, 18),
                   datetime(1997, 9, 3, 6, 6)
               ])
    }

    func testHourlyByHourAndSecond() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 0, 6),
                   datetime(1997, 9, 2, 18, 0, 18),
                   datetime(1997, 9, 3, 6, 0, 6)
               ])
    }

    func testHourlyByMinuteAndSecond() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 6, 6),
                   datetime(1997, 9, 2, 9, 6, 18),
                   datetime(1997, 9, 2, 9, 18, 6)
               ])
    }

    func testHourlyByHourAndMinuteAndSecond() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byhour=(6, 18),
        //                              byminute=(6, 18),
        //                              bysecond=(6, 18),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 18, 6, 6),
                   datetime(1997, 9, 2, 18, 6, 18),
                   datetime(1997, 9, 2, 18, 18, 6)
               ])
    }

    func testHourlyBySetPos() {
        //        self.assertEqual(list(rrule(HOURLY,
        //                              count=3,
        //                              byminute=(15, 45),
        //                              bysecond=(15, 45),
        //                              bysetpos=(3, -3),
        //                              dtstart=datetime(1997, 9, 2, 9, 0))),
        expect(RRule(starting: datetime(1997, 9, 2, 9, 0),
                     frequency: .hourly,
                     count: 3),
               toMatch: [
                   datetime(1997, 9, 2, 9, 15, 45),
                   datetime(1997, 9, 2, 9, 45, 15),
                   datetime(1997, 9, 2, 10, 15, 45)
               ])
    }

}
