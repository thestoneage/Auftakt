//
//  BarView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 18.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct BarView: View {
    let bars: Int
    let repetitions: Int
    let currentBar: Int
    let currentRep: Int
    let gapLength:CGFloat = 0.005
    let isRunning: Bool
    let currentTempo: Double
    let lineWidth = RotationalView.lineWidth
    
    var barLength: CGFloat {
        return (1.0 - (CGFloat(bars) * gapLength)) / CGFloat(bars)
    }
    
    var repititionLength: CGFloat {
        return (1.0 - (CGFloat(repetitions) * gapLength)) / CGFloat(repetitions)
    }
    
    func barStart(number: Int) -> CGFloat {
        CGFloat(number) * (barLength + gapLength)
    }
    
    func barEnd(number: Int) -> CGFloat {
        barStart(number: number) + barLength
    }
    
    func repStart(number: Int) -> CGFloat {
        CGFloat(number) * (repititionLength + gapLength)
    }
    
    func repEnd(number: Int) -> CGFloat {
        repStart(number: number) + repititionLength
    }

    
    func colorOfBar(at bar: Int) -> Color {
        guard isRunning else {
            return Color.blue
        }
        if bar == (currentBar - 1) % (bars) {
            return Color.red
        }
        return Color.blue
    }

    func colorOfRep(at rep: Int) -> Color {
        guard isRunning else {
            return Color.blue
        }
        if (rep) == (currentRep - 1)  % (repetitions) {
            return Color.red
        }
        return Color.blue
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.bgLane)
            ForEach(0..<repetitions, id: \.self) { bar in
                Circle()
                    .trim(from: repStart(number: bar), to: repEnd(number: bar))
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(colorOfRep(at: bar))
            }
            Group {
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(.bgLane)

                ForEach(0..<bars, id: \.self) { bar in
                    Circle()
                        .trim(from: barStart(number: bar), to: barEnd(number: bar))
                        .stroke(lineWidth: lineWidth)
                        .foregroundColor(colorOfBar(at: bar))
                }
            }
            .padding(lineWidth * 2.0)
        }
        .padding(lineWidth/2.0)
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(bars: 4, repetitions: 3, currentBar:4, currentRep: 1, isRunning: true, currentTempo: 120)
    }
}
