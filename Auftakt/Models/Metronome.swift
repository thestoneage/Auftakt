//
//  Metronome.swift
//  MyMetronome
//
//  Created by Marc Rummel on 30.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

struct Metronome: Codable {
    var tempo: Tempo
    var measure: Measure
    
    var description: String {
        "\(tempo.description) BPM, \(measure.description)"
    }
}

extension Metronome {
    static let defaultMetronome = Metronome(tempo: Tempo(bpm: 120),
                                            measure: Measure(beats: .four, note: .quarter))
}
