//
//  File.swift
//
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
                defer { day = day.nextDay }
                return day
            }
        }

        func day(for weekday: Weekday) -> Day {
            days.first { $0.weekday == weekday }!
        }

    }

}

extension Units {

    struct WeekSequence: Sequence, IteratorProtocol {

        var year: Year
        var calendar: Calendar { year.calendar }

        var week: Week
        let interval: Int

        init(_ week: Week, interval: Int) {
            year = week.year

            self.week = week
            self.interval = interval
        }

        mutating func next() -> Week? {
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
