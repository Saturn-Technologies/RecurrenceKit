//
//  File 2.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

public extension RRule {

    enum Weekday: String, CaseIterable {

        case sunday = "SU"
        case monday = "MO"
        case tuesday = "TU"
        case wednesday = "WE"
        case thursday = "TH"
        case friday = "FR"
        case saturday = "SA"

        init(_ string: String) throws {
            guard let weekday = Weekday(rawValue: string.uppercased()) else {
                throw NSError()
            }

            self = weekday
        }

        init(intValue: Int) {
            var i = intValue

            i = i % 7
            if i < 0 {
                i += 7
            }

            self = Weekday.allCases[i]
        }

        var intValue: Int {
            Self.allCases.firstIndex(of: self)!
        }

        static func + (lhs: Weekday, rhs: Int) -> Weekday {
            Weekday(intValue: lhs.intValue + rhs)
        }

    }

    struct NWeekday {

        let n: Int
        let weekday: Weekday

        public init(_ n: Int, _ weekday: Weekday) {
            self.n = n
            self.weekday = weekday
        }

    }

//    struct ForeverSequence: Sequence, IteratorProtocol {
//
//        var year: Int
//        let interval: Int
//        let months: [MonthName]
//        let days: [Int]
//
//        typealias Element = OldYearSequence.Element
//
//        var yearIterator: OldYearSequence.Iterator
//
//        init(starting _: Day,
//             interval _: Int,
//             months _: [MonthName] = MonthName.allCases,
//             days _: [Int] = Array(1 ... 31)) {
//
//            fatalError()
    ////            year = day.year
    ////            self.interval = interval
    ////            self.months = months
    ////            self.days = days
    ////
    ////            yearIterator = OldYearSequence(starting: day,
    ////                                           months: months,
    ////                                           days: days).makeIterator()
//        }
//
//        mutating func next() -> Element? {
//            while true {
//                if let next = yearIterator.next() {
//                    return next
//                }
//
//                year += interval
//                yearIterator = OldYearSequence(starting: .never
//                                               /* Day(year: year,
//                                                month: .january,
//                                                day: 1) */,
//                                               months: months,
//                                               days: days).makeIterator()
//            }
//        }
//
//    }

//
//    struct OldYearSequence: Sequence {
//
//        let start: Day
//        let year: Int
//        let months: [Units.Month.Name]
//        let days: [Int]
//
//        typealias Element = Day
//
//        init(starting day: Day,
//             months: [Units.Month.Name] = Units.Month.Name.allCases,
//             days: [Int] = Array(1 ... 31)) {
//            start = day
    ////            year = day.year
//            fatalError()
//            self.months = months
//            self.days = days
//        }
//
//        func makeIterator() -> LazyFilterSequence<LazyMapSequence<LazyCombination<[Units.Month.Name], [Int]>, RRule.Day>>.Iterator {
//            LazyCombination(months, days)
//                .lazy
//                .map { _ -> Day in
//                    fatalError()
    ////                    Day(year: year, month: $0, day: $1)
//                }
//                .filter {
//                    if $0 >= start {
    ////                        print("allowing \($0)")
//                        return true
//                    } else {
//                        return false
//                    }
//                }
//                .makeIterator()
//        }
//
//    }

}

struct LazyCombination<A, B>: Sequence, IteratorProtocol where A: Sequence, B: Sequence {

    var a: A.Element?
    let b: B
    var aIterator: A.Iterator
    var bIterator: B.Iterator?

    typealias Element = (A.Element, B.Element)

    typealias Iterator = Self

    init(_ a: A, _ b: B) {
        aIterator = a.makeIterator()
        self.b = b
    }

    func makeIterator() -> Self {
        self
    }

    mutating func next() -> (A.Element, B.Element)? {
        if let a = a,
           let b = bIterator?.next() {
            return (a, b)
        }

        if let a = aIterator.next() {
            self.a = a
            bIterator = b.makeIterator()

            if let b = bIterator?.next() {
                return (a, b)
            } else {
                // b must be empty
                return nil
            }
        }

        return nil
    }

}

public extension RRule {

//    var oldDaySequence: ForeverSequence {
//        fatalError()
    ////        let (year, month, day, _, _, _) = dtStart!.tuple
    ////        let start = Day(year: year,
    ////                        month: MonthName(rawValue: month)!,
    ////                        day: day)
    ////
    ////        let yearInterval: Int
    ////        if frequency == .yearly {
    ////            yearInterval = interval
    ////        } else {
    ////            yearInterval = 1
    ////        }
    ////
    ////        return ForeverSequence(starting: start,
    ////                               interval: yearInterval,
    ////                               months: bymonth ?? MonthName.allCases,
    ////                               days: bymonthday ?? Array(1 ... 31))
//    }

    func all() -> [DateComponents] {
        let (_, _, _, hour, minute, second) = dtStart!.tuple
        let start = initialYear.day(for: dtStart!)

        let startTime = Units.Time(hour: hour, minute: minute, second: second)

        return daySequence
            .combining(timeSequence)
            .lazy
            .compactMap { day, time -> DateComponents? in
                guard day.isValid(for: start) else {
                    return nil
                }

                if day == start, time < startTime {
                    return nil
                }

                return day.components(with: time.hour, time.minute, time.second)
            }
            .limited(to: count)
            .asArray
    }

}

struct Limit<S>: Sequence, IteratorProtocol where S: Sequence {

    typealias Element = S.Element

    var numberLeft: Int
    var iterator: S.Iterator

    init(_ sequence: S, limit: Int?) {
        numberLeft = limit ?? .max
        iterator = sequence.makeIterator()
    }

    func makeIterator() -> Self {
        self
    }

    mutating func next() -> Element? {
        if numberLeft == 0 { return nil }
        numberLeft -= 1

        return iterator.next()
    }

}

extension Sequence {

    func combining<S>(_ other: S) -> LazyCombination<Self, S> {
        LazyCombination(self, other)
    }

    func limited(to limit: Int?) -> Limit<Self> {
        Limit(self, limit: limit)
    }

    func eraseToAnySequence() -> AnySequence<Element> {
        AnySequence(self)
    }

}
