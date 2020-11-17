//
//  MetronomeTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 27.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class BeatsTests: XCTestCase {

    func testNext() throws {
        XCTAssertEqual(Beats.one.next, Beats.two)
        XCTAssertEqual(Beats.two.next, Beats.three)
    }

    func testPrev() {
        XCTAssertEqual(Beats.two.prev, Beats.one)
        XCTAssertEqual(Beats.three.prev, Beats.two)
    }

    func testNextNil() throws {
        XCTAssertNil(Beats.sixteen.next)
    }

    func testPrevNil() {
        XCTAssertNil(Beats.one.prev)
    }

    func testDescripton() throws {
        XCTAssertEqual(Beats.one.description, "1")
    }
}

class AccentTests: XCTestCase {
    func testCycle() {
        let accent = Accent.normal
        XCTAssertEqual(accent.cycled, Accent.accent)
        XCTAssertEqual(accent.cycled.cycled, Accent.mute)
    }
}

class MeasureTests: XCTestCase {

    func testAccent() throws {
        var measure = Measure(beats: .one, note: .quarter)
        measure.subdiv = .identity
        XCTAssertEqual(measure.accents, [.normal])
        measure.subdiv = .double
        XCTAssertEqual(measure.accents, [.normal, .subdiv])
        measure.subdiv = .triplet
        XCTAssertEqual(measure.accents, [.normal, .subdiv, .subdiv])
    }

    func testInitial() throws {
        let measure = Measure.defaultMeasure
        XCTAssertNil(measure.activeBeatIndex)
        XCTAssertNil(measure.activeSubdivIndex)
    }

    func testTickSubdivFromInitial() {
        var m = Measure.defaultMeasure
        m.tickSubdiv()
        XCTAssertEqual(m.activeBeatIndex, 0)
        XCTAssertEqual(m.activeSubdivIndex, 0)
        XCTAssertEqual(m.currentAccent, .normal)
        m.tickSubdiv()
        XCTAssertEqual(m.activeBeatIndex, 1)
        XCTAssertEqual(m.activeSubdivIndex, 1)
        XCTAssertEqual(m.currentAccent, .normal)
        var n = Measure.defaultMeasure
        n.subdiv = .double
        n.tickSubdiv()
        XCTAssertEqual(n.activeBeatIndex, 0)
        XCTAssertEqual(n.activeSubdivIndex, 0)
        XCTAssertEqual(n.currentAccent, .normal)
        n.tickSubdiv()
        XCTAssertEqual(n.activeBeatIndex, 0)
        XCTAssertEqual(n.activeSubdivIndex, 1)
        XCTAssertEqual(n.currentAccent, .subdiv)
    }

    func testDescripton() throws {        XCTAssertEqual(Measure(beats: .three, note: .quarter).description, "3/4")
    }

}


