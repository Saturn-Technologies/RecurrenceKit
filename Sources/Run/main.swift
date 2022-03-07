//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

import Foundation
import RRule

let rrule = RRule(starting: datetime(1997, 9, 2, 9, 0),
                  frequency: .yearly,
                  byMonth: [.january, .march],
                  byNWeekday: [.init(3, .tuesday),
                               .init(-3, .thursday)],
                  count: 3)
let expected = [
    datetime(1998, 1, 15, 9, 0),
    datetime(1998, 1, 20, 9, 0),
    datetime(1998, 3, 12, 9, 0)
]
let result = rrule.all()

print("\nEXPECTED:")
for d in expected {
    print(d.serialized)
}

print("\nRESULT:")
for d in result {
    print(d.serialized)
}

assert(expected == result)

// var lastContext = RRule.WeekContext(year: 1289, weekStart: .monday)
//
// for i in 1290 ... 3025 {
//    let context = RRule.WeekContext(year: i, weekStart: .monday)
//
//    let difference = context.startOfFirstWeek.timeIntervalSince(lastContext.startOfFirstWeek) / (7 * 24 * 60 * 60)
//    let expected = Int(round(difference))
//    print("expected: \(expected)")
//
//    let result = lastContext.numberOfWeeks
//    print("result: \(result)")
//
//    if i != 1583 {
//        assert(result == expected)
//    }
//    print("")
//
//    lastContext = context
// }

// let rrule = RRule(starting: datetime(1997, 9, 2, 9, 0),
//                   frequency: .monthly,
//                   byMonth: [.january, .march],
//                   byDayOfMonth: [5, 7],
//                   count: 3)
//
// print("...")
// let x = rrule.all()
// print("done!")
// print(x.map(\.serialized).joined(separator: "\n"))

func datetime(_ year: Int,
              _ month: Int,
              _ day: Int,
              _ hour: Int = 0,
              _ minute: Int = 0,
              _ second: Int = 0) -> DateComponents {
    DateComponents(year: year,
                   month: month,
                   day: day,
                   hour: hour,
                   minute: minute,
                   second: second)
}
