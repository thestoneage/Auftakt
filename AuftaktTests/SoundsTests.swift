//
//  PracticeTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 24.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class SoundsTests: XCTestCase {

    func testURLs() throws {
        for sound in Instrument.allCases {
            XCTAssertNotNil(sound.sounds.accent)
            XCTAssertNotNil(sound.sounds.normal)
            XCTAssertNotNil(sound.sounds.subdiv)
        }
    }
    
}
