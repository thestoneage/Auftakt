//
//  TabTempo.swift
//  MyMetronome
//
//  Created by Marc Rummel on 21.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

struct TabTempo {
    var tabAt: Date?
    var intervals: [TimeInterval] = []

    var meanInterval: TimeInterval? {
        guard intervals != [] else {
            return nil
        }
        return intervals.reduce(.zero, +)/TimeInterval(intervals.count)
    }

    var meanBPM: Double? {
        guard let meanInterval = meanInterval else { return nil }
        return 60.0 / meanInterval
    }

    mutating func append(interval: TimeInterval) {
        guard let meanInterval = meanInterval else {
            intervals.append(interval)
            return
        }
        guard (abs(interval - meanInterval) / meanInterval) < 0.2 else {
            intervals = []
            return
        }
        if intervals.count >= 4 {
            intervals.removeFirst()
        }
        intervals.append(interval)
    }

    mutating func tab() {
        guard let lastTabAt = tabAt else { tabAt = Date(); return }
        tabAt = Date()
        let interval = tabAt!.timeIntervalSince(lastTabAt)
        append(interval: interval)
    }
}
