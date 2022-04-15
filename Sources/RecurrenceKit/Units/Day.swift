//
//  Day.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/6/22.
//

// swiftlint:disable all

import Foundation

public extension Units {

    struct Day: Hashable, Comparable, CustomDebugStringConvertible {

        static var never: Day { fatalError() }

        var month: Month
        var day: Int

        var year: Year { month.year }

        init(month: Month, day: Int) {
            self.month = month
            self.day = day
        }

        var nextDay: Day {
            get throws {
                if isLastDayInMonth {
                    return try Day(month: month.nextMonth, day: 1)
                } else {
                    return Day(month: month, day: day + 1)
                }
            }
        }

        var isLastDayInMonth: Bool {
            month.numberOfDays == day
        }

        var ordinalityInYear: Int {
            month.ordinalityOfFirstDay + day - 1
        }

        var weekday: Weekday {
            let diff = ordinalityInYear - year.ordinalityOfFirstDayInFirstWeek
            return year.weekStart + diff
        }

        var isValid: Bool {
            day > 0 && day <= month.numberOfDays
        }

        func isValid(for start: Day) -> Bool {
            isValid && self >= start
        }

        public var debugDescription: String {
            "\(weekday) \(year.year)-\(month.month)-\(day)"
        }

        public static func < (lhs: Units.Day, rhs: Units.Day) -> Bool {
            if lhs.month == rhs.month {
                return lhs.day < rhs.day
            } else {
                return lhs.month < rhs.month
            }
        }

    }

}

extension Units {

    struct DaySequence: Sequence, IteratorProtocol {

        var year: Units.Year
        var month: Units.Month
        var day: Units.Day
        let interval: Int
        var error: Error?

        typealias Element = Day

        init(_ day: Day, interval: Int) {
            self.day = day
            month = day.month
            year = month.year
            self.interval = interval
        }

        mutating func next() -> Day? {
            if error != nil { return nil }

            defer { increment() }
            return day
        }

        mutating func increment() {
            day.day += interval
            if day.day < 28 { return }

            do {
                var daysInMonth = month.numberOfDays
                while day.day > daysInMonth {
                    day.day -= daysInMonth

                    if month.month == .december {
                        year = try year.nextYear
                        month = year.firstMonth
                        day.month = month
                    } else {
                        month.month = month.month + 1
                        day.month = month
                    }

                    daysInMonth = month.numberOfDays
                }
            } catch {
                self.error = error
            }
        }

    }

}

extension Units.Day {

    var components: DateComponents {
        DateComponents(
            year: year.year,
            month: month.month.rawValue,
            day: day
        )
    }

    func components(
        with hour: Int,
        _ minute: Int,
        _ second: Int,
        timeZone: TimeZone? = nil
    ) -> DateComponents {
        DateComponents(
            timeZone: timeZone,
            year: year.year,
            month: month.month.rawValue,
            day: day,
            hour: hour,
            minute: minute,
            second: second
        )
    }

}
