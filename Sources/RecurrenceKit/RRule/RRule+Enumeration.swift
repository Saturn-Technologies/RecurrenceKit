//
//  RRule+Enumeration.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 4/12/22.
//

import Foundation

extension RRule {

    func dateComponents() throws -> AnySequence<DateComponents> {
        guard let dtStart = dtStart else { return [].eraseToAnySequence() }
        let (_, _, _, hour, minute, second) = dtStart.tuple
        let start = try initialYear.day(for: dtStart)
        let startTime = Units.Time(hour: hour, minute: minute, second: second)

        return try daySequence
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
            .eraseToAnySequence()
    }

    public func dates(in range: Range<Date>) throws -> AnySequence<Date> {
        guard let calendar = dtStart?.calendar else { return [].eraseToAnySequence() }

        return try dateComponents()
            .lazy
            .compactMap(calendar.date)
            .filter(range.contains)
            .eraseToAnySequence()
    }

}
