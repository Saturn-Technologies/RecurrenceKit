//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/6/22.
//

import Foundation

public extension Units {

    struct Time: Hashable, Comparable {

        let hour: Int
        let minute: Int
        let second: Int

        public static func < (lhs: Time, rhs: Time) -> Bool {
            guard lhs.hour == rhs.hour else {
                return lhs.hour < rhs.hour
            }

            guard lhs.minute == rhs.minute else {
                return lhs.minute < rhs.minute
            }

            return lhs.second < rhs.second
        }

    }

}
