//
//  Year.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/6/22.
//

import Foundation

public typealias WeekContext = Units.Year

public extension Units {

    class Year: Hashable, Comparable {

        public var calendar: Calendar
        public let weekStart: Weekday
        public let year: Int
        public let isLeapYear: Bool
        private weak var _predecessor: Year?
        internal var predecessor: Year {
            if let predecessor = _predecessor {
                return predecessor
            }

            let predecessor = Year(
                year: year - 1,
                weekStart: weekStart,
                calendar: calendar
            )
            _predecessor = predecessor
            return predecessor
        }

        private(set) var ordinalityOfFirstDayInFirstWeek: Int
        private var integerStartOfFirstWeek: IntegerDay!
        var startOfFirstWeek: Day {
            day(for: integerStartOfFirstWeek)
        }

        private let numberOfDaysPerMonth: [Int]
        private let ordinalitiesForMonth: [Int]

        private var _nextYear: Year?
        public var nextYear: Year {
            if let nextYear = _nextYear {
                return nextYear
            }

            let nextYear = getNextYear()
            _nextYear = nextYear
            return nextYear
        }

        private var _numberOfWeeks: Int?
        public var numberOfWeeks: Int {
            if let numberOfWeeks = _numberOfWeeks {
                return numberOfWeeks
            }

            let numberOfWeeks = calculateNumberOfWeeks()
            _numberOfWeeks = numberOfWeeks
            return numberOfWeeks
        }

        /// creates a `Year` object and caches some calculations from `Calendar`
        /// - Parameters:
        ///   - year: the year of the `Year`, ie, `1970`
        ///   - weekStart: the `weekStart` of the RRule, typically `.monday`
        ///   - calendar: a `Calendar` object that has been set up for us by `DTStart`
        ///   - predecessor: for internal use, a reference to the previous year
        ///   - continuingThroughYear: a year after which we should abort
        ///   - continuingUntilDeviceDate: a system date which will be compared with .now after which we should abort
        public init(
            year: Int,
            weekStart: Weekday,
            calendar: Calendar,
            predecessor: Year? = nil
        ) {
            precondition(calendar.firstWeekday == weekStart.intValue + 1)

            let components = DateComponents(
                weekday: weekStart.intValue + 1,
                weekOfYear: 1,
                yearForWeekOfYear: year
            )
            let weekOne = calendar.date(from: components)!
            let weekTwo = calendar.date(byAdding: .weekOfYear, value: 1, to: weekOne)!
            let weekTwoOrdinality = calendar.ordinality(of: .day, in: .year, for: weekTwo)!

            if weekTwoOrdinality <= 4 {
                ordinalityOfFirstDayInFirstWeek = weekTwoOrdinality
            } else {
                ordinalityOfFirstDayInFirstWeek = weekTwoOrdinality - 7
            }

            self.calendar = calendar
            self.weekStart = weekStart
            self.year = year

            isLeapYear = Year.isLeapYear(year)
            let fd = isLeapYear ? 29 : 28
            numberOfDaysPerMonth = [
                31, fd, 31, 30, 31, 30,
                31, 31, 30, 31, 30, 31
            ]

            var acc = 1
            ordinalitiesForMonth = numberOfDaysPerMonth.map { i -> Int in
                defer { acc += i }
                return acc
            }

            if ordinalityOfFirstDayInFirstWeek < 1 {
                let predecessor = predecessor ?? Year(
                    year: year - 1,
                    weekStart: weekStart,
                    calendar: calendar
                )
                _predecessor = predecessor

                integerStartOfFirstWeek = predecessor.lastMonth
                    .day(31 + ordinalityOfFirstDayInFirstWeek)
                    .integerDay
            } else {
                integerStartOfFirstWeek = firstMonth
                    .day(ordinalityOfFirstDayInFirstWeek)
                    .integerDay
            }
        }

        var firstWeek: Week {
            Week(self, week: 1)
        }

        var lastWeek: Week {
            Week(self, week: numberOfWeeks)
        }

        var firstMonth: Month {
            Month(year: self, month: .january)
        }

        var lastMonth: Month {
            Month(year: self, month: .december)
        }

        func dayWithOrdinality(_ ordinality: Int) -> Day {
            var ordinality = ordinality

            if ordinality < 1 {
                return predecessor.lastMonth.day(31 + ordinality)
            }

            for (i, numberOfDays) in numberOfDaysPerMonth.enumerated() {
                if ordinality <= numberOfDays {
                    precondition(ordinality > 0)
                    return month(for: .init(rawValue: i + 1)!).day(ordinality)
                }

                ordinality -= numberOfDays
            }

            fatalError("day not found")
        }

        func firstDay(of week: Int) -> Day {
            let ordinality = ordinalityOfFirstDay(in: week)
            return dayWithOrdinality(ordinality)
        }

        var numberOfDays: Int {
            isLeapYear ? 366 : 365
        }

        private func getNextYear() -> Year {
            Year(
                year: year + 1,
                weekStart: weekStart,
                calendar: calendar,
                predecessor: self
            )
        }

        private func year(for yearInt: Int) -> Year {
            if yearInt < self.year {
                return predecessor.year(for: yearInt)
            }

            if yearInt > self.year {
                return nextYear.year(for: yearInt)
            }

            return self
        }

        func calculateNumberOfWeeks() -> Int {
            let numberOfDaysInYear = isLeapYear ? 366 : 365
            let nextDay = nextYear.ordinalityOfFirstDayInFirstWeek + numberOfDaysInYear
            let diff = nextDay - ordinalityOfFirstDayInFirstWeek
            let (q, r) = diff.quotientAndRemainder(dividingBy: 7)
            return r < 4 ? q : q + 1
        }

        static func isLeapYear(_ year: Int) -> Bool {
            if year % 4 == 0 {
                if year % 100 == 0 {
                    return year % 400 == 0
                } else {
                    return true
                }
            } else {
                return false
            }
        }

        func month(for name: Month.Name) -> Month {
            Month(year: self, month: name)
        }

        func day(for dtStart: DTStart) -> Day {
            month(for: dtStart)
                .day(dtStart.day)
        }

        func day(for components: DateComponents) -> Day {
            if components.year! < year {
                return predecessor.day(for: components)
            } else if components.year! > year {
                return nextYear.day(for: components)
            }

            return month(for: Units.Month.Name(rawValue: components.month!)!)
                .day(components.day!)
        }

        func day(for yearDay: Int) -> Day {
            dayWithOrdinality(yearDay)
        }

        func day(for integerDay: IntegerDay) -> Day {
            let year = year(for: integerDay.year)
            let month = year.month(for: integerDay.month)
            return month.day(integerDay.day)
        }

        func week(for dtStart: DTStart) -> Week {
            week(for: dtStart.day, of: dtStart.month)
        }

        func month(for dtStart: DTStart) -> Month {
            month(for: Units.Month.Name(rawValue: dtStart.month)!)
        }

        private func week(for day: Int, of month: Int) -> Week {
            let ordinality = ordinalitiesForMonth[month - 1] + day - 1
            let diff = ordinality - ordinalityOfFirstDayInFirstWeek

            let (q, _) = diff.quotientAndRemainder(dividingBy: 7)
            let week = Week(self, week: q + 1)

            let found = week.days.first { d in
                d.day == day && d.month.month.rawValue == month
            }
            assert(found != nil)

            return week
        }

        func week(for day: Day) -> Week {
            week(for: day.day, of: day.month.month.rawValue)
        }

        func numberOfDays(in month: Month.Name) -> Int {
            numberOfDaysPerMonth[month.rawValue - 1]
        }

        func ordinalityOfFirstDay(in month: Month.Name) -> Int {
            ordinalitiesForMonth[month.rawValue - 1]
        }

        func ordinalityOfFirstDay(in week: Int) -> Int {
            ordinalityOfFirstDayInFirstWeek + (week - 1) * 7
        }

        private func weeks(while predicate: (Week) -> Bool) -> [Week] {
            var week = predecessor.lastWeek
            var weeks = [Week]()

            while true {
                guard predicate(week) else {
                    return weeks
                }

                weeks.append(week)
                week = week.nextWeek
            }
        }

        var weeks: [Week] {
            var i = 0
            var weeks = weeks { _ in
                defer { i += 1 }
                return i < 60
            }

            weeks = weeks.filter { week in
                week.days.contains { $0.year == self }
            }

            return weeks
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(year)
        }

        public static func < (lhs: Units.Year, rhs: Units.Year) -> Bool {
            lhs.year < rhs.year
        }

        public static func == (lhs: Units.Year, rhs: Units.Year) -> Bool {
            lhs.year == rhs.year
        }

    }

}

extension Units {

    struct YearSequence: Sequence, IteratorProtocol {

        let context: EnumerationContext

        var year: Units.Year
        let interval: Int

        typealias Element = Units.Year

        init(
            _ year: Units.Year,
            interval: Int,
            context: EnumerationContext
        ) {
            self.context = context
            self.year = year
            self.interval = interval
        }

        mutating func next() -> Element? {
            guard context.shouldContinue(for: year) else {
                return nil
            }

            defer { increment() }
            return year
        }

        mutating func increment() {
            for _ in 1 ... interval {
                incrementOnce()
            }
        }

        mutating func incrementOnce() {
            year = year.nextYear
        }

    }

}
