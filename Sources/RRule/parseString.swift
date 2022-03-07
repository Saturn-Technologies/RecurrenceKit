//
//  parseString.swift
//
//
//  Created by Gregory Fajen on 3/1/22.
//

import Foundation

// import { Options, Frequency } from './types'
// import { Weekday } from './weekday'
// import dateutil from './dateutil'
// import { Days } from './rrule'

protocol Option { }

enum RRuleError: Error {
    case unrecognizedProperty
}
