//
//  Month.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/6/22.
//

// swiftlint:disable all

import Foundation

public extension Units {

    struct Month: Hashable, Comparable {

        let year: Year
        var month: Name

        init(year: Year, month: Name) {
            self.year = year
            self.month = month
        }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            if lhs.year == rhs.year {
                return lhs.month < rhs.month
            } else {
                return lhs.year < rhs.year
            }
        }

        func day(_ day: Int) -> Day {
            Day(month: self, day: day)
        }

        var numberOfDays: Int {
            year.numberOfDays(in: month)
        }

        var ordinalityOfFirstDay: Int {
            year.ordinalityOfFirstDay(in: month)
        }

        var firstDay: Day {
            day(1)
        }

        var lastDay: Day {
            day(numberOfDays)
        }

        var nextMonth: Month {
            get throws {
                if month == .december {
                    return try year.nextYear.firstMonth
                } else {
                    return Month(year: year, month: month + 1)
                }
            }
        }

        private func weeks(while predicate: (Week) -> Bool) throws -> [Week] {
            var week = try year.week(for: firstDay)
            var weeks = [Week]()

            while true {
                guard predicate(week) else {
                    return weeks
                }

                weeks.append(week)
                week = try week.nextWeek
            }
        }

        var weeks: [Week] {
            get throws {
                var i = 0
                var weeks = try weeks { _ in
                    defer { i += 1 }
                    return i < 7
                }

                weeks = weeks.filter { week in
                    week.days.contains { $0.month == self }
                }

                return weeks
            }
        }

    }

}

public extension Units.Month {

    enum Name: Int, Comparable, Hashable, CaseIterable {

        case january = 1
        case february = 2
        case march = 3
        case april = 4
        case may = 5
        case june = 6
        case july = 7
        case august = 8
        case september = 9
        case october = 10
        case november = 11
        case december = 12

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }

        public static func + (lhs: Self, rhs: Int) -> Name {
            Name(rawValue: lhs.rawValue + rhs)!
        }

        public static func += (lhs: inout Self, rhs: Int) {
            lhs = lhs + rhs
        }

    }

}

extension Units {

    struct MonthSequence: Sequence, IteratorProtocol {

        var month: Units.Month
        let interval: Int
        var error: Error?

        typealias Element = Units.Month

        init(_ month: Units.Month, interval: Int) {
            self.month = month
            self.interval = interval
        }

        mutating func next() -> Units.Month? {
            if error != nil { return nil }

            defer { increment() }
            return month
        }

        mutating func increment() {
            do {
                for _ in 1 ... interval {
                    try incrementOnce()
                }
            } catch {
                self.error = error
            }
        }

        mutating func incrementOnce() throws {
            if month.month == .december {
                month = try month.year.nextYear.firstMonth
            } else {
                month.month += 1
            }
        }

    }

}

@available(*, deprecated)
public typealias MonthName = Units.Month.Name
