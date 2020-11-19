//
//  MetronomePresetView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 31.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct MetronomePresetRowView: View {
    let metronomePreset: MetronomePreset
    var isBold: Bool = false
    
    var body: some View {
        (Text("\(metronomePreset.name)\n") +
            Text(metronomePreset.metronome.description).font(.caption))
            .fontWeight(isBold ? .bold : .regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
    }
}

struct MetronomePresetListView: View {
    let saveTitle = NSLocalizedString("Save", comment: "Title of the save Buton")
    let navbarTitle = NSLocalizedString("Metronome Presets", comment: "Title of Metronome Preset View")
    let textFieldTitle = NSLocalizedString("Preset Title", comment: "Title of the Textfield to name Preset")
    let addModeTitle = NSLocalizedString("Add Preset from current Metronome …", comment: "Heading for the TextField")
    let editModeTitle = NSLocalizedString("Edit Title of Preset", comment: "Title of the Textfield to rename Preset")
    
    @Environment(\.presentationMode) var presentationMode

    @AppStorage(MetronomePreset.key) var presets: [MetronomePreset] = MetronomePreset.initialPresets
    
    @Binding var metronome: Metronome

    @State var editMode: EditMode = .inactive
    
    @State private var addMode = false
    @State private var presetTitle = ""
    
    @State private var editTitle = ""
    @State private var editPreset: MetronomePreset?
    
    var body: some View {
        NavigationView {
            VStack {
                if addMode {
                    VStack(alignment: .leading) {
                        Text(addModeTitle).font(.caption)
                        HStack {
                            TextField(textFieldTitle, text: $presetTitle)
                            Button(action: { add() }) {
                                Text(saveTitle)
                            }.disabled(presetTitle.isEmpty)
                        }
                    }.padding()
                }
                if editPreset != nil {
                    VStack(alignment: .leading) {
                        Text(editModeTitle).font(.caption)
                        HStack {
                            TextField(textFieldTitle, text: $editTitle)
                            Button(action: { edit() }) {
                                Text(saveTitle)
                            }.disabled(editTitle.isEmpty)
                        }
                    }.padding()
                }
                List {
                    ForEach(presets, id: \.self.id) { preset in
                        MetronomePresetRowView(metronomePreset: preset, isBold: preset.id == editPreset?.id)
                            .onTapGesture {
                                if editMode == .active {
                                    editPreset = preset
                                    editTitle = preset.name
                                }
                                else {
                                    metronome = preset.metronome
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                    }
                    .onDelete { indexSet in
                        presets.remove(atOffsets: indexSet)
                    }
                }
                .navigationBarTitle(Text(presetTitle), displayMode: .inline)
                .navigationBarItems(leading:
                                        Button(action: {
                                            presetTitle = ""
                                            addMode.toggle()
                                        }) {
                                            Image(systemName: "plus")
                                        }.disabled(editMode == .active),
                                    trailing:
                                        EditButton())
                .environment(\.editMode, $editMode)
            }
        }
    }
    
    func edit() {
        editPreset?.name = editTitle
        if let editedPreset = self.editPreset {
            if let idx = self.presets.firstIndex(where: { $0.id == editedPreset.id}) {
                self.presets[idx] = editedPreset
            }
        }
        self.editPreset = nil
    }
    
    func add() {
        presets.append(MetronomePreset(name: presetTitle, metronome: metronome))
        addMode.toggle()
    }
}

struct MetronomePresetListView_Previews: PreviewProvider {
    
    static var previews: some View {
        MetronomePresetListView(metronome: .constant(Metronome.defaultMetronome))
    }
}
