//
//  DateComponents+Extension.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

extension DateComponents {

    init(rfcString: String) throws {
        let regex = try RegEx("^(\\d{4})(\\d{2})(\\d{2})(T(\\d{2})(\\d{2})(\\d{2})(Z?))?")
        guard let match = regex.match(for: rfcString) else {
            throw NSError()
        }

        var timeZone: TimeZone?
        if match.captureGroups[7] == "Z" {
            timeZone = TimeZone(identifier: "GMT")
        }

        guard let year = match.captureGroups[0],
              let month = match.captureGroups[1],
              let day = match.captureGroups[2]
        else {
            throw NSError()
        }

        if let hour = match.captureGroups[4],
           let minute = match.captureGroups[5],
           let second = match.captureGroups[6] {
            self = DateComponents(
                timeZone: timeZone,
                year: Int(year),
                month: Int(month),
                day: Int(day),
                hour: Int(hour),
                minute: Int(minute),
                second: Int(second)
            )
        } else {
            self = DateComponents(
                timeZone: timeZone,
                year: Int(year),
                month: Int(month),
                day: Int(day)
            )
        }
    }

    var isGMT: Bool {
        timeZone?.identifier == "GMT"
    }

    public var serialized: String {
        let year = year ?? 0
        let month = month ?? 0
        let day = day ?? 0
        let date = String(format: "%04d%02d%02d", year, month, day)

        let hour = hour ?? 0
        let minute = minute ?? 0
        let second = second ?? 0

        let includeTime = isGMT || hour > 0 || minute > 0 || second > 0
        if includeTime {
            let time = String(format: "%02d%02d%02d", hour, minute, second)
            return date + "T" + time + (isGMT ? "Z" : "")
        } else {
            return date
        }
    }

}
