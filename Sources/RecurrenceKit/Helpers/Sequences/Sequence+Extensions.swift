//
//  Sequence+Extensions.swift
//  RRules
//
//  Created by Gregory Fajen on 4/12/22.
//

import Foundation

extension Sequence {

    func combining<S>(_ other: S) -> LazyCombination<Self, S> {
        LazyCombination(self, other)
    }

    func limited(to limit: Int?) -> Limit<Self> {
        Limit(self, limit: limit)
    }

    func eraseToAnySequence() -> AnySequence<Element> {
        AnySequence(self)
    }

}
