//
//  File 2.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

import Foundation

extension RRule {

    func interval(for frequency: Frequency) -> Int {
        frequency == self.frequency ? interval : 1
    }

    var initialYear: Units.Year {
        guard let dtStart = dtStart else { fatalError() }

        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = weekStart.intValue + 1

        if let timeZone = dtStart.timeZone {
            calendar.timeZone = timeZone
        }

        return Units.Year(year: dtStart.year,
                          weekStart: weekStart,
                          calendar: calendar)
    }

    var daySequence: AnySequence<Units.Day> {
        switch frequency {
            case .yearly:
                if bymonth != nil, bynweekday != nil {
                    fallthrough
                }
                return yearlyDaySequence

            case .monthly:
                return monthlyDaySequence

            default:
                break
        }

        let months = bymonth ?? Units.Month.Name.allCases
        let days = bymonthday ?? Array(1 ... 31)

        if bynweekday != nil {
            if bymonth != nil {
                return monthlyDaySequence
            } else {
                return monthlyDaySequence
            }
        }

        switch frequency {
            case .yearly:
                fatalError()

            case .monthly:
                fatalError()

            case .weekly:
                let dtStart = dtStart!
                let year = initialYear
                let week = year.week(for: dtStart)

                let s = Units.WeekSequence(week, interval: interval(for: .weekly))
                    .lazy
                    .flatMap(\.days)
                return process(daySequence: s)

            case .daily:
                if interval == 1 {
                    fallthrough
                } else {
                    let start = initialYear.day(for: dtStart!)
                    let s = Units.DaySequence(start, interval: interval(for: .daily))
                    return process(daySequence: s)
                }

            default:
                let s = Units.YearSequence(initialYear, interval: interval(for: .yearly))
                    .lazy
                    .flatMap { year in
                        months
                            .combining(days)
                            .lazy
                            .map { month, day in
                                year.month(for: month).day(day)
                            }
                    }
                return process(daySequence: s)
        }
    }

    func process<S>(daySequence: S) -> AnySequence<Units.Day> where S: Sequence, S.Element == Units.Day {
        let predicates = predicates
        let start = initialYear.day(for: dtStart!)

        return daySequence
            .lazy
            .filter { day in
                day.isValid(for: start) && predicates.allSatisfy { predicate in
                    predicate.isSatisfied(by: day)
                }
            }
            .eraseToAnySequence()
    }

}

// MARK: - Yearly

extension RRule {

    private typealias YearToDayTransform = (Units.Year) -> Units.Day
    private typealias YearToDaysTransform = (Units.Year) -> [Units.Day]

    var yearlyDaySequence: AnySequence<Units.Day> {
        let s = Units.YearSequence(initialYear,
                                   interval: interval(for: .yearly))
            .lazy
            .flatMap(yearToDaysTransform)

        return process(daySequence: s)
    }

    private var yearToNWeekdayTransforms: [YearToDaysTransform] {
        bynweekday?.map { weekday in
            { year in
                if let day = dayForNWeekday(weekday, year: year) {
                    return [day]
                } else {
                    return []
                }
            }
        } ?? []
    }

    private var yearToYearDayTransforms: [YearToDaysTransform] {
        byyearday?.map { yearDay in
            { year in
                [self.dayForYearDay(yearDay, year: year)]
            }
        } ?? []
    }

    private var yearToWeekNoTransforms: [YearToDaysTransform] {
        byweekno?.map { weekNo in
            { year in
                self.daysForWeekNo(weekNo, year: year)
            }
        } ?? []
    }

    private var yearToDayTransforms: [YearToDaysTransform] {
        yearToNWeekdayTransforms + yearToYearDayTransforms + yearToWeekNoTransforms
    }

    private var yearToDaysTransform: YearToDaysTransform {
        if let transforms = yearToDayTransforms.unlessEmpty {
            return { year in
                transforms
                    .lazy
                    .flatMap { $0(year) }
                    .sorted()
                    .map { day in
                        print(year)
                        print(transforms)
                        return day
                    }
            }
        } else {
            let months = bymonth ?? Units.Month.Name.allCases
            let days = bymonthday ?? Array(1 ... 31)

            return { year in
                months
                    .combining(days)
                    .lazy
                    .map { month, day in
                        year.month(for: month).day(day)
                    }
            }
        }
    }

    private func dayForNWeekday(_ nWeekday: NWeekday, year: Units.Year) -> Units.Day? {
        let candidates = year
            .weeks
            .map { $0.day(for: nWeekday.weekday) }
            .filter { $0.isValid && $0.year == year }

        var i = nWeekday.n - 1
        if i < 0 {
            i += candidates.count + 1
        }

        guard i >= 0, i < candidates.count else {
            return nil
        }

        return candidates[i]
    }

    private func dayForYearDay(_ yearDay: Int, year: Units.Year) -> Units.Day {
        if yearDay > 0 {
            return year.day(for: yearDay)
        } else {
            return year.day(for: year.numberOfDays + yearDay + 1)
        }
    }

    private func daysForWeekNo(_ weekNo: Int, year: Units.Year) -> [Units.Day] {
        if weekNo > year.numberOfWeeks { return [] }

        let week = Units.Week(year, week: weekNo)
        var days = week.days

        let old = Units.Week(year.predecessor, week: weekNo)
        days.append(contentsOf: old.days)

        let new = Units.Week(year.nextYear, week: weekNo)
        days.append(contentsOf: new.days)

        return days
            .filter { $0.isValid && $0.year == year }
            .sorted()
    }

}

// MARK: - Monthly

extension RRule {

    private typealias MonthToDayTransform = (Units.Month) -> Units.Day
    private typealias MonthToDaysTransform = (Units.Month) -> [Units.Day]

    var monthlyDaySequence: AnySequence<Units.Day> {
        let month = initialYear.month(for: dtStart!)
        let s = Units.MonthSequence(month,
                                    interval: interval(for: .monthly))
            .lazy
            .flatMap(specialTransform)

        return process(daySequence: s)
    }

    private var specialTransform: MonthToDaysTransform {
        guard let byNWeekday = bynweekday else {
            return normalTransform
        }

        return { month in
            byNWeekday
                .compactMap { weekday in
                    dayForNWeekday(weekday, month: month)
                }
                .sorted()
                .map { day in
                    day
                }
        }
    }

    private var normalTransform: MonthToDaysTransform {
        let days = bymonthday ?? Array(1 ... 31)
        return { month in
            days.map { day -> Units.Day in
                Units.Day(month: month, day: day)
            }
        }
    }

    private func dayForNWeekday(_ nWeekday: NWeekday, month: Units.Month) -> Units.Day? {
        let candidates = month
            .weeks
            .map { $0.day(for: nWeekday.weekday) }
            .filter { $0.isValid && $0.month == month }

        var i = nWeekday.n - 1
        if i < 0 {
            i += candidates.count + 1
        }

        print("💡 dayForNWeekday(\(nWeekday), month: \(month.month) \(month.year.year)")

        guard i >= 0, i < candidates.count else {
            print("     returning nil")
            return nil
        }

        print("     returning \(candidates[i])")
        return candidates[i]
    }

}

// MARK: - Unsorted

extension RRule.Weekday: CustomDebugStringConvertible {

    public var debugDescription: String {
        rawValue
    }

}
