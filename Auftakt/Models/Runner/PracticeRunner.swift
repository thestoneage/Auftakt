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

class PracticeRunner: Runable, Tickable {
    static let practiceKey = "PracticeKey"
    static let soundKey = "PracticeSoundKey"
    
    @Published var practice: Practice
    @Published var isRunning: Bool = false
    
    var countIn: Bool {
        practice.countingIn
    }
    
    var measure: Measure {
        get { practice.measure }
        set { practice.measure = newValue }
    }
    
    var bpm: Double {
        get { practice.currentTempo }
    }
    
    var runner: Runner = Runner()
    
    @AppStorage(soundKey) var instrument: Instrument = Instrument.wood {
        didSet {
            runner.sound = instrument.sounds
        }
    }

    init() {
        self.practice = Self.loadCurrentPractice() ?? Practice.defaultPractice
        self.practice = Practice.defaultPractice
        runner.delegate = self
        runner.sound = instrument.sounds
    }
    
    func start()  {
        runner.start()
        practice.start()
    }
    
    func stop() {
        runner.stop()
        practice.stop()
    }
    
    internal func fireBar() {
        practice.tickBar()
        if practice.bar == nil {
            stop()
        }
    }
        
    static func loadCurrentPractice() -> Practice? {
        if let saved = UserDefaults.standard.object(forKey: Self.practiceKey) as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(PracticeData.self, from: saved) {
                return Practice(data: decoded)
            }
        }
        return nil
    }

    func saveCurrent() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.practice.data) {
            UserDefaults.standard.set(encoded, forKey: Self.practiceKey)
        }
    }
}
