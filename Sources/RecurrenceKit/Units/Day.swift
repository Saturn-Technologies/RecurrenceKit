//
//  Day.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/6/22.
//

// swiftlint:disable all

import Foundation

public extension Units {

    struct IntegerDay {
        let year: Int
        let month: Month.Name
        let day: Int
    }

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
            if isLastDayInMonth {
                return Day(month: month.nextMonth, day: 1)
            } else {
                return Day(month: month, day: day + 1)
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

        var integerDay: IntegerDay {
            IntegerDay(
                year: year.year,
                month: month.month,
                day: day
            )
        }

    }

}

extension Units {

    struct DaySequence: Sequence, IteratorProtocol {

        let context: EnumerationContext

        var day: Units.Day
        let interval: Int

        var year: Units.Year { month.year }
        var month: Units.Month { day.month }

        typealias Element = Day

        init(
            _ day: Day,
            interval: Int,
            context: EnumerationContext
        ) {
            self.context = context
            self.day = day
            self.interval = interval
        }

        mutating func next() -> Day? {
            guard context.shouldContinue(for: year) else {
                return nil
            }

            defer { increment() }
            return day
        }

        mutating func increment() {
            day.day += interval
            if day.day < 28 { return }

            var daysInMonth = month.numberOfDays
            while day.day > daysInMonth {
                day.day -= daysInMonth
                day.month = day.month.nextMonth
                daysInMonth = month.numberOfDays
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
