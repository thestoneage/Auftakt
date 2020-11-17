//
//  TabTempoTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 21.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class TabTempoTests: XCTestCase {

    func testMean() throws {
        let tabTempo1 = TabTempo(intervals: [0.5, 0.5, 0.5, 0.5])
        XCTAssertEqual(tabTempo1.meanInterval, 0.5)
        XCTAssertEqual(tabTempo1.meanBPM, 120.0)

        let tabTempo2 = TabTempo(intervals: [0.5, 0.7, 0.5, 0.7])
        XCTAssertEqual(tabTempo2.meanInterval, 0.6)
        XCTAssertEqual(tabTempo2.meanBPM, 100.0)
    }

    func testAppendIntervalWithUnfilledIntervals() throws {
        var tabTempo = TabTempo(intervals: [0.5, 0.5])
        tabTempo.append(interval: 0.5)
        XCTAssertEqual(tabTempo.intervals, [0.5, 0.5, 0.5])
    }

    func testAppendIntervalWithFilledIntervals() throws {
        var tabTempo = TabTempo(intervals: [0.4, 0.5, 0.5, 0.5])
        tabTempo.append(interval: 0.5)
        XCTAssertEqual(tabTempo.intervals, [0.5, 0.5, 0.5, 0.5])
    }

    func testAppendIntervalWithBigDeviation() throws {
        var tabTempo = TabTempo(intervals: [0.5, 0.5, 0.5, 0.5])
        tabTempo.append(interval: 1.0)
        XCTAssertEqual(tabTempo.intervals, [])
    }

}
