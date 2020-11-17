//
//  Subdiv.swift
//  MyMetronome
//
//  Created by Marc Rummel on 03.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

enum Subdiv: Double, Codable, CaseIterable, Cyclable {
    case identity   = 1.0
    case double     = 2.0
    case triplet    = 3.0
}

import SwiftUI

extension Subdiv {
    func image(with note: Note) -> UIImage {
        return UIImage(named: name(with: note))!
    }

    func name(with note: Note) -> String {
        switch self {
        case .identity:
            return note.name
        case .double:
            return note.name + "-double"
        case .triplet:
            return note.name + "-triplet"
        }
    }
}
