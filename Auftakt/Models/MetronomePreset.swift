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
}
