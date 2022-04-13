//
//  RRuleSet.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

public struct RRuleSet {

    public let start: DTStart
    public let rule: RRule

    enum Property: String, CaseIterable {
        case dtstart = "DTSTART"
        case rrule = "RRULE"
        case exrule = "EXRULE"
    }

    public init(start: DTStart, rule: RRule) {
        self.start = start
        self.rule = rule
    }

    public init(rfcString: String) throws {
        let options = try [Option](rfcString: rfcString)

        let start = options.compactMap { $0 as? DTStart }.first
        let rule = options.compactMap { $0 as? RRule }.first

        self.start = start!
        self.rule = rule!
    }

    public var serialized: String {
        start.serialized + "\n" + rule.serialized
    }

}

extension Array where Element == Option {

    init(rfcString: String) throws {
        func parseLine(rfcString: String) throws -> Option {
            switch try RRuleSet.Property(line: rfcString) {
                case .dtstart:
                    return try DTStart(rfcString: rfcString)

                case .rrule:
                    return try RRule(rfcString: rfcString)

                case .exrule:
                    fatalError()
            }
        }

        self = try rfcString
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .map(parseLine)
    }

}

extension RRuleSet.Property {

    init(line: String) throws {
        let line = line.uppercased()

        for property in Self.allCases {
            if line.starts(with: property.rawValue) {
                self = property
                return
            }
        }

        throw RRuleError.unrecognizedProperty
    }

}
