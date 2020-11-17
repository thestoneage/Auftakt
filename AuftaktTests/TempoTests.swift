//
//  MyMetronomeTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 11.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class TempusTests: XCTestCase {

    func testTempo() throws {
        XCTAssertEqual(Tempus(bpm: 41), Tempus.grave)
        XCTAssertEqual(Tempus(bpm: 42), Tempus.grave)
        XCTAssertEqual(Tempus(bpm: 220), Tempus.prestissimo)
        XCTAssertNil(Tempus(bpm: 5))
    }

    func testFaster() throws {
        XCTAssertEqual(Tempus.grave.next, Tempus.largo)
        XCTAssertEqual(Tempus.prestissimo.next, nil)
    }

    func testSlower() throws {
        XCTAssertEqual(Tempus.largo.prev, Tempus.grave)
        XCTAssertEqual(Tempus.grave.prev, nil)
    }

}

class TempoTest: XCTestCase {
    
    func testBPM() throws {
        var t = Tempo(bpm: 120)
        XCTAssertEqual(t.bpm, 120)
        t.bpm = Tempo.max + 10
        XCTAssertEqual(t.bpm, Tempo.max)
        t.bpm = Tempo.min - 10
        XCTAssertEqual(t.bpm, Tempo.min)
    }
    
    func testTempusSet() throws {
        var t = Tempo(bpm: 120)
        t.tempus = .grave
        XCTAssertEqual(t.bpm, Tempus.grave.bounds.lowerBound)
    }

    func testTempusGet() throws {
        let t = Tempo(bpm: Tempus.grave.bounds.lowerBound)
        XCTAssertEqual(t.tempus, Tempus.grave)
    }
}
