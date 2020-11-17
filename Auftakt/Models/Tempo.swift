//
//  Tempo.swift
//  MyMetronome
//
//  Created by Marc Rummel on 26.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

struct Tempo: Codable, Equatable {
    static let min: Double = 40
    static let max: Double = 240
    
    private var _bpm: Double = 0.0
    
    init(bpm: Double) {
        self.bpm = bpm
    }
    
    var bpm: Double {
        get {
            _bpm
        }
        set {
            _bpm = newValue.clamped(lowerBound: Tempo.min, upperBound: Tempo.max)
        }
    }

    var tempus: Tempus? {
        get {
            return Tempus(bpm: bpm)
        }
        set {
            if let newValue = newValue {
                bpm = newValue.bounds.lowerBound
            }
        }
    }
    
    var description: String {
        Int(bpm).description
    }
}


enum Tempus: CaseIterable {
    case grave
    case largo
    case lento
    case adagio
    case larghetto
    case adagietto
    case andante
    case andantino
    case maestoso
    case moderato
    case allegretto
    case animato
    case allegro
    case assai
    case vivace
    case presto
    case prestissimo
}

extension Tempus: Neighboring {
    var bounds: Range<Double> {
        switch self {
        case .grave:
            return 40..<44
        case .largo:
            return 44..<48
        case .lento:
            return 48..<54
        case .adagio:
            return 54..<58
        case .larghetto:
            return 58..<63
        case .adagietto:
            return 63..<69
        case .andante:
            return 69..<76
        case .andantino:
            return 76..<84
        case .maestoso:
            return 84..<92
        case .moderato:
            return 92..<104
        case .allegretto:
            return 104..<116
        case .animato:
            return 116..<126
        case .allegro:
            return 126..<138
        case .assai:
            return 138..<152
        case .vivace:
            return 152..<176
        case .presto:
            return 176..<200
        case .prestissimo:
            return 200..<241
            
        }
    }

    var description: String {
        return "\(self)"
    }
    
    init?(bpm: Double) {
        guard let t = Self.allCases.first(where: { $0.bounds.contains(bpm) }) else { return nil }
        self = t
    }
}
