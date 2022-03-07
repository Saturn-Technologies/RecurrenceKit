//
//  File 2.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

extension Sequence {

    var asArray: [Element] {
        Array(self)
    }

}

extension Collection {

    var unlessEmpty: Self? {
        isEmpty ? nil : self
    }

}

extension Sequence where Element: Hashable {

    var asSet: Set<Element> {
        Set(self)
    }

}

extension RRule {

    enum Predicate {
        case byMonth(Set<Units.Month.Name>)
        case byWeekday(Set<Weekday>)
        case byMonthDay(Set<Int>)
    }

    var predicates: [Predicate] {
        var predicates = [Predicate]()

        if let byMonth = bymonth {
            predicates.append(.byMonth(byMonth.asSet))
        }

        if let byMonthDay = bymonthday {
            predicates.append(.byMonthDay(byMonthDay.asSet))
        }

        if let byWeekday = byweekday {
            predicates.append(.byWeekday(byWeekday.asSet))
        }

        return predicates
    }

}

extension RRule.Predicate {

    func isSatisfied(by day: Units.Day) -> Bool {
        switch self {
            case let .byWeekday(weekdays):
                return weekdays.contains(day.weekday)

            case let .byMonth(months):
                return months.contains(day.month.month)

            case let .byMonthDay(monthDays):
                return monthDays.contains(day.day)
        }
    }

}

// extension RRule.OldDay {
//
//    var calendar: Calendar {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.timeZone = TimeZone(identifier: "GMT")!
//        return calendar
//    }
//
//    var date: Date {
//        calendar.date(from: DateComponents(year: year,
//                                           month: month.rawValue,
//                                           day: day))!
//    }
//
//    var weekday: RRule.Weekday {
//        let i = calendar.component(.weekday, from: date) - calendar.firstWeekday
//        return RRule.Weekday.allCases[i]
//    }
//
//    func matches(_ weekdays: [RRule.NWeekday]) -> Bool {
//        weekdays.contains(where: matches)
//    }
//
//    func matches(_ weekday: RRule.NWeekday) -> Bool {
//        guard weekday.n > 0 else { return false }
//
//        guard self.weekday == weekday.weekday else {
//            return false
//        }
//
//        fatalError()
//    }
//
// }
