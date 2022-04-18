//
//  File.swift
//
//
//  Created by Gregory Fajen on 4/18/22.
//

import Foundation

struct EnumerationContext {

    let continuingThroughYear: Int
    let continuingUntilDeviceDate: Date

    init(
        continuingThroughYear: Int = 2500,
        continuingUntilDeviceDate: Date = Date() + 0.25
    ) {
        self.continuingThroughYear = continuingThroughYear
        self.continuingUntilDeviceDate = continuingUntilDeviceDate
    }

    init(
        through date: Date,
        in calendar: Calendar,
        timeout: TimeInterval = 0.25
    ) {
        self = .init(
            through: calendar.dateComponents(
                [.year],
                from: date
            ),
            timeout: timeout
        )
    }

    init(
        through dateComponents: DateComponents,
        timeout: TimeInterval = 0.25
    ) {
        continuingThroughYear = dateComponents.year ?? 2500
        continuingUntilDeviceDate = Date() + timeout
    }

    func shouldContinue(for year: Int) -> Bool {
        guard year <= continuingThroughYear else {
            return false
        }

        guard continuingUntilDeviceDate > Date() else {
            return false
        }

        return true
    }

    func shouldContinue(for year: Units.Year) -> Bool {
        shouldContinue(for: year.year)
    }

}
