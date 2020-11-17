//
//  StaticRunner.swift
//  MyMetronome
//
//  Created by Marc Rummel on 07.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MetronomeRunner: Runable, Tickable {
    static let key      = "MetronomeKey"
    static let soundKey = "MetronomeSoundKey"
    
    @Published var metronome: Metronome
    @Published var isRunning: Bool = false

    var countIn: Bool = false
    
    var measure: Measure {
        get { metronome.measure }
        set { metronome.measure = newValue }
    }
    
    var bpm: Double {
        metronome.tempo.bpm
    }
    
    @AppStorage(soundKey) var instrument: Instrument = Instrument.wood {
        didSet {
            runner.sound = instrument.sounds
        }
    }

    var runner: Runner = Runner()
    
    init() {
        self.metronome = Self.loadCurrent() ?? Metronome.defaultMetronome
        runner.delegate = self
        runner.sound = instrument.sounds
    }
    
    func start()  {
        runner.start()
    }
    
    func stop() {
        runner.stop()
    }
        
    static func loadCurrent() -> Metronome? {
        if let saved = UserDefaults.standard.object(forKey: Self.key) as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Metronome.self, from: saved) {
                return decoded
            }
        }
        return nil
    }
    
    func saveCurrent() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.metronome) {
            UserDefaults.standard.set(encoded, forKey: Self.key)
        }
    }
        
    internal func fireBar() {
    }
}
