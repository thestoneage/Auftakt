//
//  Practice.swift
//  MyMetronome
//
//  Created by Marc Rummel on 23.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

struct Practice: Codable {
    var startTempo: Double
    var endTempo: Double
    var tempoIncrement: Double
    var bars: Int
    var repetitions: Int
    var measure: Measure

    var currentBar: Int
    var countIn: Bool
    var countingIn: Bool {
        return currentBar < 1
    }

    var currentRepetition: Int {
        if countingIn {
            return 0
        }
        return  1 + (currentBar - 1) / (bars)
    }

    var currentTempo: Double {
        let value = Double(((currentBar - 1) / (bars * repetitions))) * tempoIncrement + startTempo
        let clampedValue = value.clamped(lowerBound: startTempo, upperBound: endTempo)
        return clampedValue
    }
    
    var description: String {
        NSLocalizedString("\(measure.description), \(Int(startTempo)) → \(Int(endTempo)) bpm, Δ\(Int(tempoIncrement)) bpm, \(bars) bars, \(repetitions) reps", comment: "Practice Description Interpolation")
    }
    
    init(startTempo: Double, endTempo: Double, tempoIncrement: Double, length: Int, repetitions: Int, measure: Measure, countIn: Bool = false) {
        self.startTempo = startTempo
        self.endTempo = endTempo
        self.tempoIncrement = tempoIncrement
        self.bars = length
        self.repetitions = repetitions
        self.measure = measure
        self.countIn = countIn
        self.currentBar = Self.resetCurrentBar(countIn: countIn)
    }

    mutating func tickBar() {
        currentBar += 1
    }

    mutating func start() {
    }
    
    mutating func stop() {
        currentBar = Self.resetCurrentBar(countIn: countIn)
    }
    
    private static func resetCurrentBar(countIn: Bool) -> Int {
        return countIn ? -1 : 0
    }
    
    static var defaultPractice: Practice {
        Practice(startTempo: 60, endTempo: 120, tempoIncrement: 20, length: 4, repetitions: 2, measure: Measure(beats: .four, note: .quarter))
    }
}
