//
//  RRule.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

public struct RRule: Option {

    public var dtStart: DTStart?
    public var weekStart = Weekday.monday
    public var frequency: Frequency?
    public var interval: Int = 1
    public var count: Int?
    public var until: DateComponents?

    var bymonth: [Units.Month.Name]?
    var byweekno: [Int]?
    var byyearday: [Int]?
    var byweekday: [Weekday]?
    var bynweekday: [NWeekday]?
    var byeaster: [Int]?
    var bymonthday: [Int]?
    var bynmonthday: [Int]?
    var bysetpos: [Int]?
    var byhour: [Int]?
    var byminute: [Int]?
    var bysecond: [Int]?

    public init(
        starting dtStart: DTStart,
        frequency: Frequency? = nil,
        interval: Int = 1,
        byMonth: [Units.Month.Name]? = nil,
        byDayOfMonth: [Int]? = nil,
        byWeekday: [Weekday]? = nil,
        byNWeekday: [NWeekday]? = nil,
        byYearDay: [Int]? = nil,
        byWeekNo: [Int]? = nil,
        byHour: [Int]? = nil,
        byMinute: [Int]? = nil,
        bySecond: [Int]? = nil,
        count: Int? = nil,
        until: DateComponents? = nil
    ) {
        self.dtStart = dtStart
        self.frequency = frequency
        self.interval = interval
        self.count = count
        self.until = until

        bymonth = byMonth
        bymonthday = byDayOfMonth
        byweekday = byWeekday
        bynweekday = byNWeekday
        byyearday = byYearDay
        byweekno = byWeekNo
        byhour = byHour
        byminute = byMinute
        bysecond = bySecond

        if byweekno == nil,
           byyearday == nil,
           bymonthday == nil,
           byweekday == nil,
           bynweekday == nil {
            switch frequency {
                case .yearly:
                    if bymonth == nil {
                        bymonth = [Units.Month.Name(rawValue: dtStart.components.month!)!]
                    }

                    bymonthday = [dtStart.components.day!]

                case .monthly:
                    bymonthday = [dtStart.components.day!]

                case .weekly:
                    byweekday = [dtStart.weekday]

                default:
                    break
            }
        }
    }

    public init(
        starting components: DateComponents,
        frequency: Frequency? = nil,
        interval: Int = 1,
        byMonth: [Units.Month.Name]? = nil,
        byDayOfMonth: [Int]? = nil,
        byWeekday: [Weekday]? = nil,
        byNWeekday: [NWeekday]? = nil,
        byYearDay: [Int]? = nil,
        byWeekNo: [Int]? = nil,
        byHour: [Int]? = nil,
        byMinute: [Int]? = nil,
        bySecond: [Int]? = nil,
        count: Int? = nil,
        until: DateComponents? = nil
    ) {
        self.init(
            starting: DTStart(components: components),
            frequency: frequency,
            interval: interval,
            byMonth: byMonth,
            byDayOfMonth: byDayOfMonth,
            byWeekday: byWeekday,
            byNWeekday: byNWeekday,
            byYearDay: byYearDay,
            byWeekNo: byWeekNo,
            byHour: byHour,
            byMinute: byMinute,
            bySecond: bySecond,
            count: count,
            until: until
        )
    }

    init(_ attributes: Attribute...) {
        self.init(attributes)
    }

    init(_ attributes: [Attribute]) {
        for attribute in attributes {
            switch attribute {
                case let .dtStart(dtStart):
                    self.dtStart = dtStart

                case let .frequency(frequency):
                    self.frequency = frequency

                case let .weekStart(weekday):
                    weekStart = weekday

                case let .interval(interval):
                    self.interval = interval

                case let .count(count):
                    self.count = count

                case let .until(components):
                    until = components

                case let .byday(array):
                    byweekday = array

                case let .byxx(byOccurrence, array):
                    switch byOccurrence {
                        case .month:
                            bymonth = array.compactMap(Units.Month.Name.init(rawValue:))
                        case .weekno:
                            byweekno = array

                        case .yearday:
                            byyearday = array
                        case .monthday:
                            bymonthday = array
                        case .day:
                            fatalError()
                        case .hour:
                            byhour = array
                        case .minute:
                            byminute = array
                        case .second:
                            bysecond = array
                        case .setpos:
                            bysetpos = array
                    }

            }
        }

        if let dtStart = dtStart,
           byweekno == nil,
           byyearday == nil,
           bymonthday == nil,
           byweekday == nil {
            switch frequency {
                case .yearly:
                    if bymonth == nil {
                        bymonth = [Units.Month.Name(rawValue: dtStart.components.month!)!]
                    }

                    bymonthday = [dtStart.components.day!]

                case .monthly:
                    fatalError()

                case .daily:
                    fatalError()

                default:
                    break
            }
        }
    }

    public var byWeekday: Set<Weekday>? {
        guard let byWeekday = byweekday,
              !byWeekday.isEmpty else {
            return nil
        }

        return Set(byWeekday)
    }

    public init(rfcString: String) throws {
        let headerRegex = RRule.headerRegex
        let attributes = try rfcString
            .replacingOccurrences(of: headerRegex, with: "")
            .split(separator: ";")
            .map { try RRule.Attribute(String($0)) }

        self = RRule(attributes)
    }

    func with(_ newAttributes: Attribute...) -> RRule {
        RRule(newAttributes + attributes)
    }

    public func normalized() -> RRule {
        guard let dtStart = dtStart else {
            return self
        }

        return RRule(
            starting: dtStart,
            frequency: frequency,
            interval: interval,
            byMonth: bymonth,
            byDayOfMonth: bymonthday,
            byWeekday: byweekday,
            byNWeekday: bynweekday,
            byYearDay: byyearday,
            byWeekNo: byweekno,
            byHour: byhour,
            byMinute: byminute,
            bySecond: bysecond,
            count: count,
            until: until
        )
    }

    static let headerRegex = try! RegEx("^(?:RRULE|EXRULE):")

    var isByWeekNo: Bool {
        attributes.contains { attribute -> Bool in
            switch attribute {
                case .byxx(.weekno, _):
                    return true
                default:
                    return false
            }
        }
    }

}

extension RRule {

    public var serialized: String {
        "RRULE:" + attributes
            .filter(shouldSerialize)
            .map(\.serialized)
            .joined(separator: ";")
    }

    func shouldSerialize(attribute: Attribute) -> Bool {
        switch attribute {
            case .dtStart:
                return false

            default:
                return true
        }
    }

}
