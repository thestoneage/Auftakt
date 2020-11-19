//
//  PracticePresetViews.swift
//  MyMetronome
//
//  Created by Marc Rummel on 03.11.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct PracticePresetRowView: View {
    let preset: PracticePreset
    var isBold: Bool = false
    
    var body: some View {
        (Text("\(preset.name)\n") + Text(preset.practice.description).font(.caption))
            .fontWeight(isBold ? .bold : .regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
    }
}

struct PracticePresetRowView_Previews: PreviewProvider {
    static var previews: some View {
        PracticePresetRowView(preset: PracticePreset.defaultPreset)
    }
}


struct PracticePresetListView: View {
    let saveTitle = NSLocalizedString("Save", comment: "Title of the save Buton")
    let navbarTitle = NSLocalizedString("Practice Presets", comment: "Title of Metronome Preset View")
    let textFieldTitle = NSLocalizedString("Preset Title", comment: "Title of the Textfield to name Preset")
    let addModeTitle = NSLocalizedString("Add Preset from current Metronome …", comment: "Heading for the TextField")
    let editModeTitle = NSLocalizedString("Edit Title of Preset", comment: "Title of the Textfield to rename Preset")

    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage(PracticePreset.key) var presets: [PracticePreset] = [PracticePreset.defaultPreset]
    
    @Binding var practice: Practice
    
    @State var editMode: EditMode = .inactive
    
    @State private var addMode = false
    @State private var presetTitle = ""
    
    @State private var editTitle = ""
    @State private var editPreset: PracticePreset?
    
    
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
                        PracticePresetRowView(preset: preset, isBold: preset.id == editPreset?.id)
                            .onTapGesture {
                                if editMode == .active {
                                    editPreset = preset
                                    editTitle = preset.name
                                }
                                else {
                                    practice = preset.practice
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        
                        
                    }.onDelete{ indexSet in
                        presets.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationBarTitle(Text(navbarTitle), displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                    }) {
                                        Image(systemName: "plus")
                                    }.disabled(editMode == .active),
                                trailing: EditButton())
            .environment(\.editMode, $editMode)
            
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
        presets.append(PracticePreset(name: presetTitle, practice: practice))
        addMode.toggle()
    }
    
}

struct PracticePresetView_Previews: PreviewProvider {
    static var previews: some View {
        PracticePresetListView(practice: .constant(Practice.defaultPractice))
    }
}
