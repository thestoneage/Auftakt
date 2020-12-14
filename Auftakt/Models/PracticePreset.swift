//
//  PracticePreset.swift
//  MyMetronome
//
//  Created by Marc Rummel on 03.11.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

struct PracticePreset: Identifiable, Codable {
    static let key: String = "PracticePresetKey"
    
    var id = UUID()
    var name: String
    var data: PracticeData = Practice.defaultPractice.data
}

extension PracticePreset {
    static var defaultPreset = PracticePreset(name: "Default Practice")
    
    static var defaultPresets =  [Self.defaultPreset]
}
