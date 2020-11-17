//
//  SubdivTests.swift
//  MyMetronomeTests
//
//  Created by Marc Rummel on 03.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import XCTest
@testable import MyMetronome

class SubdivTests: XCTestCase {

    func testImages() throws {
        for subdiv in Subdiv.allCases {
            for note in Note.allCases {
                let image = subdiv.image(with: note)
                XCTAssert(image.isKind(of: UIImage.self))
            }
        }
    }
    
    func testNames() throws {
        for subdiv in Subdiv.allCases {
            for note in Note.allCases {
                let name = subdiv.name(with: note)
                XCTAssertFalse(name.isEmpty)
            }
        }
    }
}
