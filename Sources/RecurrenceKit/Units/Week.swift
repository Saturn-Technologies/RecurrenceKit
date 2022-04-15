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

        init(_ year: Year, week: Int) throws {
            var week = week
            if week < 0 {
                week += try year.numberOfWeeks + 1
            }

            self.year = year
            self.week = week
        }

        var nextWeek: Week {
            get throws {
                if try isLastWeekOfYear {
                    return try year.nextYear.firstWeek
                } else {
                    return try Week(year, week: week + 1)
                }
            }
        }

        var startOfWeek: Day {
            get throws {
                try year.firstDay(of: week)
            }
        }

        var ordinalityOfFirstDay: Int {
            year.ordinalityOfFirstDay(in: week)
        }

        var isLastWeekOfYear: Bool {
            get throws {
                try week == year.numberOfWeeks
            }
        }

        var isValid: Bool {
            do {
                return try week > 0 && week <= year.numberOfWeeks
            } catch {
                return false
            }
        }

        var days: [Units.Day] {
//            get throws {
            do {
                guard isValid else { return [] }

                var day = try startOfWeek
                precondition(day.isValid)

                return try (0 ..< 7).map { _ in
                    let thisDay = day
                    day = try day.nextDay
                    return thisDay
                }
            } catch {
                return []
            }
        }

        func day(for weekday: Weekday) throws -> Day {
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

        var error: Error?

        init(_ week: Week, interval: Int) {
            year = week.year

            self.week = week
            self.interval = interval
        }

        mutating func next() -> Week? {
            print("WeekSequence.next()")
            if error != nil { return nil }

            defer { increment() }
            return week
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
            if try week.isLastWeekOfYear {
                year = try year.nextYear
                week = try year.firstWeek
            } else {
                week.week += 1
            }
        }

    }

}
