//
//  LazyCombination.swift
//  RecurrenceKit
//
//  Created by Gregory Fajen on 4/12/22.
//

import Foundation

struct LazyCombination<A, B>: Sequence, IteratorProtocol where A: Sequence, B: Sequence {

    var a: A.Element?
    let b: B
    var aIterator: A.Iterator
    var bIterator: B.Iterator?

    typealias Element = (A.Element, B.Element)

    typealias Iterator = Self

    init(_ a: A, _ b: B) {
        aIterator = a.makeIterator()
        self.b = b
    }

    func makeIterator() -> Self {
        self
    }

    mutating func next() -> (A.Element, B.Element)? {
        if let a = a,
           let b = bIterator?.next() {
            return (a, b)
        }

        if let a = aIterator.next() {
            self.a = a
            bIterator = b.makeIterator()

            if let b = bIterator?.next() {
                return (a, b)
            } else {
                // b must be empty
                return nil
            }
        }

        return nil
    }

}
