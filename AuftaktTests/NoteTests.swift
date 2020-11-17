//
//  NoteTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 04.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class NoteTests: XCTestCase {
    func testNext() throws {
        XCTAssertEqual(Note.quarter.next, Note.eighth)
    }

    func testPrev() {
        XCTAssertEqual(Note.eighth.prev, Note.quarter)
    }

    func testNextNil() throws {
        XCTAssertNil(Note.sixteenth.next)
    }

    func testPrevNil() {
        XCTAssertNil(Note.half.prev)
    }

    func testDescripton() throws {
        XCTAssertEqual(Note.half.description, "2")
    }

    func testImages() throws {
        for note in Note.allCases {
            let image = note.image
            XCTAssert(image.isKind(of: UIImage.self))
        }
    }
}
