
//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

import Foundation

extension RRule {

    private var hours: [Int] {
        byhour ?? [dtStart!.hour]
    }

    private var minutes: [Int] {
        byminute ?? [dtStart!.minute]
    }

    private var seconds: AnySequence<Int> {
        if let bySecond = bysecond {
            return bySecond.eraseToAnySequence()
        }

        let initial = dtStart!.second

        if frequency == .secondly {
            return (0...)
                .lazy
                .map { i in
                    (initial + i * interval) % 60
                }
                .eraseToAnySequence()
        } else {
            return [initial].eraseToAnySequence()
        }
    }

    var timeSequence: AnySequence<Units.Time> {
        hours
            .combining(minutes)
            .combining(seconds)
            .lazy
            .map { hourAndMinute, second in
                let (hour, minute) = hourAndMinute
                return Units.Time(hour: hour, minute: minute, second: second)
            }
            .eraseToAnySequence()
    }

}
