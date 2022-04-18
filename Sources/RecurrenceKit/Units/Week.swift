//
//  Week.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/6/22.
//

import Foundation

public extension Units {

    struct Week {

        let year: Year
        var week: Int

        var calendar: Calendar { year.calendar }

        init(_ year: Year, week: Int) {
            var week = week
            if week < 0 {
                week += year.numberOfWeeks + 1
            }

            self.year = year
            self.week = week
        }

        var nextWeek: Week {
            if isLastWeekOfYear {
                return year.nextYear.firstWeek
            } else {
                return Week(year, week: week + 1)
            }
        }

        var startOfWeek: Day {
            year.firstDay(of: week)
        }

        var ordinalityOfFirstDay: Int {
            year.ordinalityOfFirstDay(in: week)
        }

        var isLastWeekOfYear: Bool {
            week == year.numberOfWeeks
        }

        var isValid: Bool {
            week > 0 && week <= year.numberOfWeeks
        }

        var days: [Units.Day] {
            guard isValid else { return [] }

            var day = startOfWeek
            precondition(day.isValid)

            return (0 ..< 7).map { _ in
                let thisDay = day
                day = day.nextDay
                return thisDay
            }
        }

        func day(for weekday: Weekday) -> Day {
            days.first { $0.weekday == weekday }!
        }

    }

}

extension Units {

    struct WeekSequence: Sequence, IteratorProtocol {

        let context: EnumerationContext

        var year: Year
        var calendar: Calendar { year.calendar }

        var week: Week
        let interval: Int

        var error: Error?

        init(
            _ week: Week,
            interval: Int,
            context: EnumerationContext
        ) {
            self.context = context
            year = week.year
            self.week = week
            self.interval = interval
        }

        mutating func next() -> Week? {
            guard context.shouldContinue(for: week.year) else {
                return nil
            }

            if error != nil { return nil }

            defer { increment() }
            return week
        }

        mutating func increment() {
            for _ in 1 ... interval {
                incrementOnce()
            }
        }

        mutating func incrementOnce() {
            if week.isLastWeekOfYear {
                year = year.nextYear
                week = year.firstWeek
            } else {
                week.week += 1
            }
        }

    }

}
