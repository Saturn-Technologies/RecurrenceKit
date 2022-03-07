//
//  DTStart.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

struct DTStart: Option {

    let components: DateComponents

    var timeZone: TimeZone? { components.timeZone }
    var timeZoneID: String? { timeZone?.identifier }

    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        return calendar
    }

    var date: Date {
        get { calendar.date(from: components)! }
        set { self = DTStart(date: newValue, timeZone: timeZone) }
    }

    init(components: DateComponents) {
        self.components = components
    }

    init(date: Date, timeZone: TimeZone? = nil) {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }

        components = calendar.dateComponents([.timeZone,
                                              .year,
                                              .month,
                                              .day,
                                              .hour,
                                              .minute,
                                              .second],
                                             from: date)
    }

    var weekday: RRule.Weekday {
        let i = calendar.component(.weekday, from: date) - calendar.firstWeekday
        return RRule.Weekday.allCases[i]
    }

    init(rfcString: String) throws {
        let regex = try! RegEx("DTSTART(?:;TZID=([^:=]*))?(?::|=)([^;\\s]+)")
        guard let match = regex.match(for: rfcString) else {
            throw NSError()
        }

        guard let dateString = match.captureGroups[1] else {
            throw NSError()
        }

        var components = try DateComponents(rfcString: dateString)

        if let timezoneID = match.captureGroups[0] {
            guard let timeZone = TimeZone(identifier: timezoneID) else {
                throw NSError()
            }

            if components.timeZone != nil,
               timeZone.identifier != "GMT"
            {
                throw NSError()
            }

            components.timeZone = timeZone
        }

        self = DTStart(components: components)
    }

    var serialized: String {
        if let timeZoneID = timeZoneID, timeZoneID != "GMT" {
            return "DTSTART;TZID=\(timeZoneID):\(components.serialized)"
        } else {
            return "DTSTART:\(components.serialized)"
        }
    }

    var year: Int {
        calendar.component(.year, from: date)
    }

    var month: Int {
        calendar.component(.month, from: date)
    }

    var day: Int {
        calendar.component(.day, from: date)
    }

    var hour: Int {
        calendar.component(.hour, from: date)
    }

    var minute: Int {
        calendar.component(.minute, from: date)
    }

    var second: Int {
        calendar.component(.second, from: date)
    }

}
