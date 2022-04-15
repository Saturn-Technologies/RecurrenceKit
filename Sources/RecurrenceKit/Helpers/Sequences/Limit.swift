//
//  Limit.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 4/12/22.
//

import Foundation

struct Limit<S>: Sequence, IteratorProtocol where S: Sequence {

    typealias Element = S.Element

    var numberLeft: Int
    var iterator: S.Iterator

    init(_ sequence: S, limit: Int?) {
        numberLeft = limit ?? .max
        iterator = sequence.makeIterator()
    }

    func makeIterator() -> Self {
        self
    }

    mutating func next() -> Element? {
        if numberLeft == 0 { return nil }
        numberLeft -= 1

        return iterator.next()
    }

}
