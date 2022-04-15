//
//  RegEx.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

struct RegEx {

    let expression: NSRegularExpression

    init(
        _ pattern: String,
        options: NSRegularExpression.Options = []
    ) throws {
        expression = try .init(pattern: pattern, options: options)
    }

    func match(
        for string: String,
        options: NSRegularExpression.MatchingOptions = []
    ) -> Match? {
        expression
            .firstMatch(
                in: string,
                options: options,
                range: rangeOfEntireString(string)
            )
            .map { result in
                Match(string, result)
            }
    }

    func rangeOfEntireString(_ string: String) -> NSRange {
        NSRange(string.startIndex ..< string.endIndex, in: string)
    }

    func rangeOfFirstMatch(
        in string: String,
        options: NSRegularExpression.MatchingOptions = []
    ) -> Range<String.Index>? {
        let range = expression.rangeOfFirstMatch(
            in: string,
            options: options,
            range: rangeOfEntireString(string)
        )
        return Range(range, in: string)
    }

    struct Match {
        let match: String
        let captureGroups: [String?]

        init(
            _ string: String,
            _ result: NSTextCheckingResult
        ) {
            func stringAtIndex(_ i: Int) -> String? {
                let range = Range(result.range(at: i), in: string)
                return range.map {
                    String(string[$0])
                }
            }

            match = stringAtIndex(0) ?? ""
            captureGroups = (1 ..< result.numberOfRanges).map(stringAtIndex)
        }
    }

}

extension String {

    func replacingOccurrences(
        of regex: RegEx,
        with substitution: String,
        options _: NSRegularExpression.MatchingOptions = []
    ) -> String {
        guard let range = regex.rangeOfFirstMatch(in: self) else { return self }
        return replacingCharacters(in: range, with: substitution)
    }

}
