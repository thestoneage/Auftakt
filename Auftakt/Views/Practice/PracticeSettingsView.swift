//
//  PracticeSettingsView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 24.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct PracticeSettingsView: View {
    let navBarTitle = NSLocalizedString("Practice Settings", comment: "Title of Practice settings sheet")
    let countInToggleTitle = NSLocalizedString("Count in", comment: "Title of Count in toggle")
    let lengthTitle = NSLocalizedString("Length in bars", comment: "Length of the practice piece")
    let repTitle = NSLocalizedString("Tempo increased after …", comment: "Tempo Increment after")
    let initialTempoTitle = NSLocalizedString("Initial Tempo", comment: "Initial Tempo of practice")
    let tempoIncrementSliderLabel = NSLocalizedString("Tempo Increment", comment: "Label of Tempo Increment Slider")
    let tempoGoalSliderLabel = NSLocalizedString("Tempo Goal", comment: "Label of Tempo Goal Slider")
    let repetitionsFormat = NSLocalizedString("repetitions", comment: "Key for pluralization of repetitions")
    let barsFormat = NSLocalizedString("bars", comment: "Key for pluralization of bars")

    
    @Binding var practice: Practice
    
    var maxIncrement: Double {
        return practice.endTempo - practice.startTempo
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Toggle(countInToggleTitle, isOn: $practice.countIn)
                }
                Section() {
                    Text(lengthTitle)
                    Stepper(String.localizedStringWithFormat(barsFormat, practice.bars),
                            value: $practice.bars, in: 1...64)
                }
                Section() {
                    Text(repTitle)
                    Stepper(String.localizedStringWithFormat(repetitionsFormat, practice.repetitions),
                            value: $practice.repetitions, in: 1...64)
                }
                Section() {
                    //            Section(header: Text("Initial Tempo")) {
                    Text(NSLocalizedString("Initial Tempo: \(Int(practice.startTempo)) BPM", comment: "Initial Tempo Interpolation"))
                    Slider(value: $practice.startTempo,
                           in: Tempo.min...(practice.endTempo - 2),
                           step: 1.0,
                           minimumValueLabel: Text("\(Int(Tempo.min))"),
                           maximumValueLabel: Text("\(Int(practice.endTempo - 2))"),
                           label:  { Text(initialTempoTitle) })
                }
                Section() {//(header: Text("Tempo Goal"))  {
                    Text(NSLocalizedString("Tempo Goal: \(Int(practice.endTempo)) BPM", comment: "Tempo Goal Interpolation"))
                    Slider(value: $practice.endTempo,
                           in: (practice.startTempo + 2)...Tempo.max,
                           step: 1.0,
                           minimumValueLabel: Text("\(Int(practice.startTempo + 2))"),
                           maximumValueLabel: Text("\(Int(Tempo.max))"),
                           label:  { Text(tempoGoalSliderLabel) })
                }
                Section() { //(header: Text("Increment")) {
                    Text(NSLocalizedString("Tempo is increased by: \(Int(practice.tempoIncrement)) BPM", comment: "Tempo Increment Interpolation"))
                    Slider(value: $practice.tempoIncrement,
                           in: 1.0...(practice.endTempo - practice.startTempo),
                           step: 1.0,
                           minimumValueLabel: Text("1"),
                           maximumValueLabel: Text("\(Int(maxIncrement))"),
                           label: { Text(tempoIncrementSliderLabel) })
                }
            }.navigationBarTitle(navBarTitle)
        }
    }
    
}

struct PracticeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeSettingsView(practice: .constant(Practice.defaultPractice))
    }
}

