//
//  TabTempoView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 21.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct TapTempoView: View {
    @Binding var tempo: Tempo
    @State var tabTempo = TabTempo()
    
    var body: some View {
        Button(action: {
            tabTempo.tab()
            if let meanBPM = self.tabTempo.meanBPM {
                tempo.bpm = meanBPM
            }
        }
        , label: {
            Text("TAP")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(5)
                .background(Color.blue)
        })
    }
}

struct TabTempoView_Previews: PreviewProvider {
    static var previews: some View {
        TapTempoView(tempo: .constant(Tempo(bpm: (120))))
    }
}
