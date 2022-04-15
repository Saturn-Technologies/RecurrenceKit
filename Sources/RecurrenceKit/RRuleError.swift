//
//  RRuleError.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 4/14/22.
//

import Foundation

enum RRuleError: String, Error, LocalizedError {

    /// during parsing, we encountered a property we don't understand
    case unrecognizedProperty

    /// we went too far into the future and bailed. not necessarily an actual error
    case _bailedAfterGoingTooFarIntoTheFuture

    /// we exceeded a certain amount of wall-time, and bailed
    case bailedAfterGoingTooLong

    // MARK: -

    var errorDescription: String? { rawValue }

    public static var bailedAfterGoingTooFarIntoTheFuture: RRuleError {
        _bailedAfterGoingTooFarIntoTheFuture
    }

}
