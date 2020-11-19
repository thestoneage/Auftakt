//
//  MetronomePreset.swift
//  MyMetronome
//
//  Created by Marc Rummel on 31.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

struct MetronomePreset: Identifiable, Codable {
    static let key: String = "MetronomePresetKey"
    
    var id = UUID()
    var name: String
    var metronome: Metronome = Metronome.defaultMetronome
    
}

extension MetronomePreset {
    static let defaultPreset = MetronomePreset(name: "Default Metronome")
    
    static let sultansOfSwing = MetronomePreset(name: "Sultans of swing",
                                                metronome: Metronome(tempo: Tempo(bpm: 152),
                                                                     measure: Measure(beats: .four, note: .quarter)))
 
    static let stairwayToHeaven = MetronomePreset(name: "Stairway to heaven",
                                                metronome: Metronome(tempo: Tempo(bpm: 82),
                                                                     measure: Measure(beats: .four, note: .quarter)))
    
    static let hallelujah = MetronomePreset(name: "Hallelujah",
                                                metronome: Metronome(tempo: Tempo(bpm: 50),
                                                                     measure: Measure(beats: .six, note: .eighth)))

    static let myWave = MetronomePreset(name: "My Wave",
                                                metronome: Metronome(tempo: Tempo(bpm: 126),
                                                                     measure: Measure(beats: .five, note: .quarter)))

    static let money = MetronomePreset(name: "Money",
                                                metronome: Metronome(tempo: Tempo(bpm: 123),
                                                                     measure: Measure(beats: .seven, note: .quarter)))
    
    static let weCanWorkItOut = MetronomePreset(name: "We can work it out",
                                                metronome: Metronome(tempo: Tempo(bpm: 110),
                                                                     measure: Measure(beats: .three, note: .quarter)))
    
    static let initialPresets = [sultansOfSwing, stairwayToHeaven, hallelujah, myWave, money, weCanWorkItOut]
    
    static let defaultPresets = [Self.defaultPreset]
}
