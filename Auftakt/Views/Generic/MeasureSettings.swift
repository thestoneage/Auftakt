//
//  MeasureSettings.swift
//  MyMetronome
//
//  Created by Marc Rummel on 23.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct MeasureSettings: View {
    @Binding var beats: Beats
    @Binding var note: Note
    @Binding var subdiv: Subdiv
    
    @State var beatsIndex: Int = 0
    
    let beatTitle = NSLocalizedString("Beats", comment: "Section header")
    let noteTitle = NSLocalizedString("Note", comment: "Section header")
    let subdivTitle = NSLocalizedString("Subdivision", comment: "Section header")
    
    init(beats: Binding<Beats>, note: Binding<Note>, subdiv: Binding<Subdiv>) {
        _beats = beats
        _note = note
        _subdiv = subdiv
        _beatsIndex = State(initialValue: Beats.allCases.firstIndex(of: beats.wrappedValue)!)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(beatTitle)) {
                    Stepper("\(beats.description)", value: $beatsIndex, in: 0...(Beats.allCases.endIndex - 1), step: 1) { started in
                        if !started {
                            beats = Beats.allCases[beatsIndex]
                        }
                    }
                }
                Section(header: Text(noteTitle)) {
                    Picker(noteTitle, selection: $note) {
                        ForEach(Note.allCases, id: \.self) { (n) in
                            Image(uiImage:
                                    UIImage(named: n.name,
                                            in: nil,
                                            with:  UIImage.SymbolConfiguration(pointSize: 32))!)
                                .tag(n)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                Section(header: Text(subdivTitle)) {
                    Picker(subdivTitle, selection: $subdiv) {
                        ForEach(Subdiv.allCases, id: \.self) { (s) in
                            Image(uiImage:
                                    UIImage(named: s.name(with: note),
                                            in: nil,
                                            with:  UIImage.SymbolConfiguration(pointSize: 32))!)
                                .tag(s)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }.navigationBarTitle(NSLocalizedString("Measure: \(beats.description)/\(note.description)", comment: "Title Interpolation"))
        }
        
    }
}

struct MeasureSettings_Previews: PreviewProvider {
    static var previews: some View {
        MeasureSettings(beats: .constant(.three), note: .constant(.quarter), subdiv: .constant(.identity))
    }
}
