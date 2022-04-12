//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

extension RRule {

    enum Attribute {
        case dtStart(DTStart)
        case frequency(Frequency)
        case weekStart(Weekday)
        case interval(Int)
        case count(Int)
        case until(DateComponents)
        case byday([Weekday])
        case byxx(ByOccurrence, [Int])

        static func dtStart(_ components: DateComponents) -> Attribute {
            .dtStart(DTStart(components: components))
        }

        var dtStart: DTStart? {
            switch self {
                case let .dtStart(start): return start
                default: return nil
            }
        }

        var frequency: Frequency? {
            switch self {
                case let .frequency(frequency): return frequency
                default: return nil
            }
        }
    }

    public enum Frequency: String {
        case yearly = "YEARLY"
        case monthly = "MONTHLY"
        case weekly = "WEEKLY"
        case daily = "DAILY"
        case hourly = "HOURLY"
        case minutely = "MINUTELY"
        case secondly = "SECONDLY"

        init(_ string: String) throws {
            guard let frequency = Frequency(rawValue: string.uppercased()) else {
                throw NSError()
            }

            self = frequency
        }
    }

    enum ByOccurrence: String {
        case month = "BYMONTH"
        case weekno = "BYWEEKNO"
        case yearday = "BYYEARDAY"
        case monthday = "BYMONTHDAY"
        case day = "BYDAY"
        case hour = "BYHOUR"
        case minute = "BYMINUTE"
        case second = "BYSECOND"
        case setpos = "BYSETPOS"
    }
}

extension RRule.Attribute {

    init(_ string: String) throws {
        let components = string.components(separatedBy: "=")
        guard components.count == 2,
              let key = components.first?.uppercased(),
              let value = components.last
        else {
            throw NSError()
        }

        self = try .init(key: key, value: value)
    }

    init(key: String, value: String) throws {
        switch key {
            case "FREQ":
                let frequency = try RRule.Frequency(value)
                self = .frequency(frequency)

            case "WKST":
                let weekday = try RRule.Weekday(value)
                self = .weekStart(weekday)

            case "INTERVAL":
                guard let value = Int(value) else { throw NSError() }
                self = .interval(value)

            case "COUNT":
                guard let value = Int(value) else { throw NSError() }
                self = .count(value)

            case "BYDAY":
                let values = try value.components(separatedBy: ",").map(RRule.Weekday.init)
                self = .byday(values)

            default:
                guard let byxx = RRule.ByOccurrence(rawValue: key) else {
                    print("UNKNOWN KEY: \(key)")
                    throw NSError()
                }

                let values = try value.components(separatedBy: ",").map { string -> Int in
                    guard let value = Int(string) else {
                        throw NSError()
                    }

                    return value
                }

                self = .byxx(byxx, values)
        }
    }

}

// MARK: - Serialization

extension RRule.Attribute {

    var key: String {
        switch self {
            case .frequency:
                return "FREQ"
            case .weekStart:
                return "WKST"
            case .interval:
                return "INTERVAL"
            case .count:
                return "COUNT"
            case .until:
                return "UNTIL"
            case .byday:
                return "BYDAY"
            case .dtStart:
                return "DTSTART"
            case let .byxx(byxx, _):
                return byxx.rawValue
        }
    }

    var serializedValue: String {
        switch self {
            case let .frequency(frequency):
                return frequency.rawValue
            case let .weekStart(day):
                return day.rawValue
            case let .interval(interval):
                return "\(interval)"
            case let .count(count):
                return "\(count)"
            case let .until(components):
                return components.serialized
            case let .byday(days):
                return days.map(\.rawValue).joined(separator: ",")
            case let .byxx(_, values):
                return values.map { "\($0)" }.joined(separator: ",")
            case let .dtStart(start):
                return start.components.serialized
        }
    }

    var serialized: String {
        "\(key)=\(serializedValue)"
    }

}
