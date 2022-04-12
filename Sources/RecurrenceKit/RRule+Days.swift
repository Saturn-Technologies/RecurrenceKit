//
//  RRule+Days.swift
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

}
