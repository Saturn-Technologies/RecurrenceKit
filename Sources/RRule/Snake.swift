//
//  File.swift
//
//
//  Created by Gregory Fajen on 3/5/22.
//

import Foundation

func makeBYXXSet<T: Comparable & Hashable>(start _: T, interval _: T, byxxx _: [T], base _: T) -> Set<T> {
//        If a `BYXXX` sequence is passed to the constructor at the same level as
//        `FREQ` (e.g. `FREQ=HOURLY,BYHOUR={2,4,7},INTERVAL=3`), there are some
//        specifications which cannot be reached given some starting conditions.
//        This occurs whenever the interval is not coprime with the base of a
//        given unit and the difference between the starting position and the
//        ending position is not coprime with the greatest common denominator
//        between the interval and the base. For example, with a FREQ of hourly
//        starting at 17:00 and an interval of 4, the only valid values for
//        BYHOUR would be {21, 1, 5, 9, 13, 17}, because 4 and 24 are not
//        coprime.
//        :param start:
//            Specifies the starting position.
//        :param byxxx:
//            An iterable containing the list of allowed values.
//        :param base:
//            The largest allowable value for the specified frequency (e.g.
//            24 hours, 60 minutes).
//        This does not preserve the type of the iterable, returning a set, since
//        the values should be unique and the order is irrelevant, this will
//        speed up later lookups.
//        In the event of an empty set, raises a :exception:`ValueError`, as this
//        results in an empty rrule.

    var cset = Set<T>()

    fatalError()
//    gcd(base,)
//    base.gcd

    //// Support a single byxxx value.
    // if isinstance(byxxx, integer_types):
//        byxxx = (byxxx, )
//
//    for num in byxxx:
//        i_gcd = gcd(self._interval, base)
//    # Use divmod rather than % because we need to wrap negative nums.
//    if i_gcd == 1 or divmod(num - start, i_gcd)[1] == 0:
//        cset.add(num)
//
//    if len(cset) == 0:
//        raise ValueError("Invalid rrule byxxx generates an empty set.")

    return cset
}
