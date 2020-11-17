//
//  SoundListView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 06.11.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct InstrumentListView: View {
    @Environment(\.presentationMode) var presentationMode

    let navBarTitle = NSLocalizedString("Select sound", comment: "Title of List of Instruments")
    
    let runner: Tickable
    
    var instruments = Instrument.allCases

    var body: some View {
        NavigationView {
            List {
                ForEach(instruments, id: \.self) { instrument in
                    Text(instrument.sounds.title)
                        .fontWeight(instrument == runner.instrument ? .bold : .regular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            runner.instrument = instrument
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }.navigationBarTitle(navBarTitle)
        }
    }
}

struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentListView(runner: (MetronomeRunner()))
    }
}
