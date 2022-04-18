//
//  RRule+Enumeration.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 4/12/22.
//

import Foundation

extension RRule {

    func dateComponents(with context: EnumerationContext) -> AnySequence<DateComponents> {
        guard let dtStart = dtStart else { return [].eraseToAnySequence() }
        let (_, _, _, hour, minute, second) = dtStart.tuple
        let start = initialYear.day(for: dtStart)
        let startTime = Units.Time(hour: hour, minute: minute, second: second)

        return daySequence(with: context)
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

    public func dates(in range: Range<Date>) -> AnySequence<Date> {
        guard let calendar = dtStart?.calendar else { return [].eraseToAnySequence() }

        let context = EnumerationContext(
            through: range.upperBound,
            in: calendar
        )

        return dateComponents(with: context)
            .lazy
            .compactMap(calendar.date)
            .filter(range.contains)
            .eraseToAnySequence()
    }

}
