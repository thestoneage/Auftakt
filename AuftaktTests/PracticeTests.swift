//
//  PracticeTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 24.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class PracticeTests: XCTestCase {

    var practice = Practice(startTempo: (120),
                            endTempo: (135),
                            tempoIncrement: 10,
                            bars: 2,
                            repetitions: 2,
                            measure: Measure.defaultMeasure)

    func testCurrentTempo() throws {
        XCTAssertEqual(practice.currentTempo, 120)
        practice.currentBar = 2
        XCTAssertEqual(practice.currentTempo, 120)
        practice.currentBar = 3
        XCTAssertEqual(practice.currentTempo, (120))
        practice.currentBar = 4
        XCTAssertEqual(practice.currentTempo, (120))
        practice.currentBar = 5
        XCTAssertEqual(practice.currentTempo, (130))
        practice.currentBar = 9
        XCTAssertEqual(practice.currentTempo, (135))
    }
    
    func testCurrentRepetition() {
        XCTAssertEqual(practice.currentRepetition, 0)
        practice.currentBar = 2
        XCTAssertEqual(practice.currentRepetition, 1)
        practice.currentBar = 3
        XCTAssertEqual(practice.currentRepetition, 2)
    }
    
    func testDescription() {
        XCTAssertEqual(practice.description, "4/4, 120 → 135 bpm, Δ10 bpm, 2 bars, 2 reps")
    }

}
