//
//  Note.swift
//  MyMetronome
//
//  Created by Marc Rummel on 04.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation
import SwiftUI

enum Note: Int, Codable, CaseIterable, Hashable, Neighboring {
    case half       = 2
    case quarter    = 4
    case eighth     = 8
    case sixteenth  = 16

    public var description: String {
        return rawValue.description
    }

    var name: String {
        switch self {
        case .half:
            return "half"
        case .quarter:
            return "quarter"
        case .eighth:
            return "eighth"
        case .sixteenth:
            return "sixteenth"
        }
    }
}

extension Note {

    //Safe if testImage succeeds
    var image: UIImage {
        return UIImage(named: name)!
    }
}


