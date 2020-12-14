//
//  Practice.swift
//  MyMetronome
//
//  Created by Marc Rummel on 23.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation
enum CountIn: Int, Codable {
    case always
    case start
    case never
}

enum BarType: Int, Codable {
    case normal
    case countIn
}

struct Bar: Codable {
    var tempo: Double
    var type: BarType
    var bar: Int
    var repetition: Int
}

struct Practice {
    var startTempo: Double
    var endTempo: Double
    var tempoIncrement: Double
    var bars: Int
    var repetitions: Int
    var measure: Measure

    var countIn: CountIn
    var countingIn: Bool {
        return bar?.type == BarType.countIn
    }
    
    var currentBar: Int {
        bar?.bar ?? 0
    }

    var currentRepetition: Int {
        bar?.repetition ?? 0
    }

    var currentTempo: Double {
        bar?.tempo ?? startTempo
    }
    
    var description: String {
        NSLocalizedString("\(measure.description), \(Int(startTempo)) → \(Int(endTempo)) bpm, Δ\(Int(tempoIncrement)) bpm, \(bars) bars, \(repetitions) reps", comment: "Practice Description Interpolation")
    }
    
    init(startTempo: Double, endTempo: Double, tempoIncrement: Double, length: Int, repetitions: Int, measure: Measure, countIn: CountIn = .never) {
        self.startTempo = startTempo
        self.endTempo = endTempo
        self.tempoIncrement = tempoIncrement
        self.bars = length
        self.repetitions = repetitions
        self.measure = measure
        self.countIn = countIn
    }

    var bar: Bar?
    mutating func tickBar() {
        bar = iterator?.next()
    }
    
    mutating func initBarList() {
        let incrementCount = Int(((endTempo - startTempo) / tempoIncrement).rounded(.up))
        let tempoList = (0...incrementCount).map { Double($0) }.map {
            min($0 * tempoIncrement + startTempo, endTempo)
        }
        barList = [Bar]()
        if countIn == .start {
            barList.append(Bar(tempo: startTempo, type: .countIn, bar: 1, repetition: 1))
        }
        for tempo in tempoList {
            if countIn == .always {
                barList.append(Bar(tempo: tempo, type: .countIn, bar: 1, repetition: 1))
            }
            for repetitionCount in (1...repetitions) {
                for barCount in (1...bars) {
                    let bar = Bar(tempo: tempo,
                                  type: .normal,
                                  bar: barCount,
                                  repetition: repetitionCount)
                    barList.append(bar)
                }
            }
        }
    }

    var barList: [Bar] = []
    var iterator: IndexingIterator<[Bar]>?
    mutating func start() {
        initBarList()
        iterator = barList.makeIterator()
        print("started")
    }
    
    mutating func stop() {
    }
    
    static var defaultPractice: Practice {
        Practice(startTempo: 60, endTempo: 120, tempoIncrement: 20, length: 4, repetitions: 2, measure: Measure(beats: .four, note: .quarter), countIn: .always)
    }
}
