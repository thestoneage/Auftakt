//
//  Bar.swift
//  MyMetronome
//
//  Created by Marc Rummel on 28.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation
import SwiftUI

enum Beats: Int, Codable, CaseIterable, Neighboring {
    case one = 1, two, three, four, five, six, seven, eight,
         nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen

    public var description: String {
        return rawValue.description
    }
}

enum Accent: Int, Codable, Cyclable {
    case normal
    case accent
    case mute
    case subdiv

    var cyclableCases: [Accent] {
        return [.normal, .accent, .mute]
    }
}

struct Measure: Codable  {
    var beats: Beats {
        didSet {
            self.accents = Measure.makeAccents(from: beats, subdiv: subdiv)
        }
    }
    var note: Note
    var accents: [Accent]
    var subdiv: Subdiv {
        didSet {
            self.accents = Measure.makeAccents(from: beats, subdiv: subdiv)
        }
    }
    var activeSubdivIndex: Int? = nil
    var activeBeatIndex:Int? = nil
    
    init(beats: Beats, note: Note, subdiv: Subdiv = .identity) {
        self.beats = beats
        self.note = note
        self.subdiv = subdiv
        self.accents = Measure.makeAccents(from: beats, subdiv: subdiv)
    }

    var isAtStartOfBar: Bool {
        return accents.startIndex == activeSubdivIndex
    }

    mutating func tickSubdiv() {
        guard let currentIndex = activeSubdivIndex else {
            activeBeatIndex = 0
            activeSubdivIndex = 0
            return
        }
        let  nextIndex = accents.index(after: currentIndex)
        guard accents.indices.contains(nextIndex) else {
            activeSubdivIndex = 0
            activeBeatIndex = 0
            return
        }
        activeSubdivIndex = nextIndex
        if accents[nextIndex] != .subdiv {
            activeBeatIndex = nextIndex
        }
    }
    
    mutating func reset() {
        activeBeatIndex = nil
        activeSubdivIndex = nil
    }

    var currentAccent: Accent? {
        guard let isActive = activeSubdivIndex else { return nil }
        return accents[isActive]
    }

    public var description: String {
        return beats.description + "/" + note.description
    }

    private static func subdivAccents(from subdiv: Subdiv) -> [Accent] {
        switch subdiv {
        case .identity:
            return [.normal]
        case .double:
            return [.normal, .subdiv]
        case .triplet:
            return [.normal, .subdiv, .subdiv]
        }
    }

    private static func makeAccents(from beats: Beats, subdiv: Subdiv) -> [Accent] {
        let s = subdivAccents(from: subdiv)
        return Array(Array(repeating: s, count: beats.rawValue).joined())
    }
    
    static var defaultMeasure: Measure {
        Measure(beats: .four, note: .quarter)
    }
}
