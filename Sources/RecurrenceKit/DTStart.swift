//
//  DTStart.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

public struct DTStart: Option {

    public let components: DateComponents

    public var timeZone: TimeZone? { components.timeZone }
    public var timeZoneID: String? { timeZone?.identifier }

    public var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        return calendar
    }

    public var date: Date {
        get { calendar.date(from: components)! }
        set { self = DTStart(date: newValue, timeZone: timeZone) }
    }

    public init(components: DateComponents) {
        self.components = components
    }

    public init(date: Date, timeZone: TimeZone? = nil) {
        var calendar = Calendar(identifier: .gregorian)
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }

        components = calendar.dateComponents(
            [
                .timeZone,
                .year,
                .month,
                .day,
                .hour,
                .minute,
                .second
            ],
            from: date
        )
    }

    public var weekday: RRule.Weekday {
        let i = calendar.component(.weekday, from: date) - calendar.firstWeekday
        return RRule.Weekday.allCases[i]
    }

    init(rfcString: String) throws {
        let regex = try RegEx("DTSTART(?:;TZID=([^:=]*))?(?::|=)([^;\\s]+)")
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
               timeZone.identifier != "GMT" {
                throw NSError()
            }

            components.timeZone = timeZone
        }

        self = DTStart(components: components)
    }

    public var serialized: String {
        if let timeZoneID = timeZoneID, timeZoneID != "GMT" {
            return "DTSTART;TZID=\(timeZoneID):\(components.serialized)"
        } else {
            return "DTSTART:\(components.serialized)"
        }
    }

    public var year: Int {
        calendar.component(.year, from: date)
    }

    public var month: Int {
        calendar.component(.month, from: date)
    }

    public var day: Int {
        calendar.component(.day, from: date)
    }

    public var hour: Int {
        calendar.component(.hour, from: date)
    }

    public var minute: Int {
        calendar.component(.minute, from: date)
    }

    public var second: Int {
        calendar.component(.second, from: date)
    }

}

extension DTStart {

    typealias Tuple = (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int)

    var tuple: Tuple {
        (components.year ?? 0, components.month ?? 0, components.day ?? 0, components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
    }

}
