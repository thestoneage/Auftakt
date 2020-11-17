//
//  Sounds.swift
//  MyMetronome
//
//  Created by Marc Rummel on 06.11.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

enum Instrument: Int, CaseIterable, Codable {
    case wood
    case tamborine
    
    var sounds: Sounds {
        switch self {
        case .tamborine:
            return Sounds.tamborine
        case .wood:
            return Sounds.wood
        }
    }
}

struct Sounds: Codable {
    var title: String
    var normal: URL?
    var accent: URL?
    var subdiv: URL?
    var beep: URL? = Bundle.main.url(forResource: "beep", withExtension: "wav")
}

extension Sounds {
    
    static var wood: Sounds {
        let title = NSLocalizedString("Wood", comment: "Title of Wood Instrument")
        let normal = Bundle.main.url(forResource: "wbl", withExtension: "wav")
        let accent = Bundle.main.url(forResource: "wbh", withExtension: "wav")
        let subdiv = Bundle.main.url(forResource: "wbl", withExtension: "wav")
        return Sounds(title: title, normal: normal, accent: accent, subdiv: subdiv)
    }
    
    static var tamborine: Sounds {
        let title = NSLocalizedString("Tamborine", comment: "Title of Tamborine Instrument")
        let normal = Bundle.main.url(forResource: "tw", withExtension: "wav")
        let accent = Bundle.main.url(forResource: "tb", withExtension: "wav")
        let subdiv = Bundle.main.url(forResource: "tb", withExtension: "wav")
        return Sounds(title: title, normal: normal, accent: accent, subdiv: subdiv)
    }
    
}
