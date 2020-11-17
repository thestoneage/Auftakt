//
//  Metronome.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 13.11.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome


class MetronomeTests: XCTestCase {

    func testDescription() throws {
        let m = Metronome(tempo: Tempo(bpm: 120), measure: Measure(beats: .three, note: .quarter))
        XCTAssertEqual(m.description, "120 BPM, 3/4")
    }
}
