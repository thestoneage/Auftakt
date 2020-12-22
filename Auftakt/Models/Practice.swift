//
//  Practice.swift
//  MyMetronome
//
//  Created by Marc Rummel on 23.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation
enum CountIn: Int, Codable, CaseIterable {
    case never
    case start
    case always
    
    var description: String {
        return "\(self)"
    }
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

struct PracticeData: Codable {
    var startTempo: Double
    var endTempo: Double
    var tempoIncrement: Double
    var bars: Int
    var repetitions: Int
    var measure: Measure
    var countIn: CountIn
}

struct Practice {
    var startTempo: Double
    var endTempo: Double
    var tempoIncrement: Double
    var bars: Int
    var repetitions: Int
    var measure: Measure
    var countIn: CountIn = .never
    
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
        Practice(startTempo: 60, endTempo: 120, tempoIncrement: 20, bars: 4, repetitions: 2, measure: Measure(beats: .four, note: .quarter), countIn: .always)
    }
}

extension Practice {
    init(data: PracticeData) {
        self.startTempo = data.startTempo
        self.endTempo = data.endTempo
        self.tempoIncrement = data.tempoIncrement
        self.bars = data.bars
        self.repetitions = data.repetitions
        self.measure = data.measure
        self.countIn = data.countIn
    }
    
    var data: PracticeData {
        PracticeData(startTempo: startTempo,
                     endTempo: endTempo,
                     tempoIncrement: tempoIncrement,
                     bars: bars,
                     repetitions: repetitions,
                     measure: measure,
                     countIn: countIn)
    }
}
