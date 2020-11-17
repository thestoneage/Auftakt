//
//  RotationalView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 23.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct RotationalView: View {
    static let lineWidth: CGFloat = PracticeSlidersSettings.strokeWidth
    
    @Binding var practice: Practice
    
    let isRunning: Bool
    
    var body: some View {
        ZStack {
            StartGoalView(start: $practice.startTempo , goal: $practice.endTempo, increment: $practice.tempoIncrement, current: practice.currentTempo, practiceRunning: isRunning)
            BarView(bars: practice.bars, repetitions: practice.repetitions, currentBar: practice.currentBar, currentRep: practice.currentRepetition, isRunning: isRunning, currentTempo: practice.currentTempo)
                .rotationEffect(.degrees(-90))
                .padding(2 * Self.lineWidth)
            VStack {
                Spacer()
                Text(Int(practice.currentTempo).description)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            .padding(Self.lineWidth * 4.5)
            .padding()
            .frame(maxWidth: .infinity)
            .aspectRatio(1.0, contentMode: .fit)
        }
    }
}

struct RotationalView_Previews: PreviewProvider {
    static var previews: some View {
        RotationalView(practice: .constant(Practice.defaultPractice), isRunning: true)
    }
}
