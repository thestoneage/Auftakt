//
//  MetronomeView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 30.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct BPMView: View {
    let bpm: Double
    let size = UIScreen.main.bounds.width / 5.0
    
    var body: some View {
        Text("000")
            .font(.system(size: size))
            .hidden()
            .overlay(
                Text(Int(self.bpm).description)
                    .font(.system(size: size)))
    }
}

struct TempusView: View {
    @Binding var tempus: Tempus?

    func prevTempo() {
        if let prev = tempus?.prev {
            tempus = prev
        }
    }

    func nextTempo() {
        if let next = tempus?.next {
            tempus = next
        }
    }

    var body: some View {
        HStack {
            Button(action: {self.prevTempo()}) {
                Text("-")
            }.disabled(!(tempus?.hasPrev ?? false))
            Text(tempus?.description ?? "")
            Button(action: {self.nextTempo()}) {
                Text("+")
            }.disabled(!(tempus?.hasNext ?? false))
        }.font(.title)
    }

}

struct TempusView_Previews: PreviewProvider {
    static var previews: some View {
        TempusView(tempus: .constant(Tempus(bpm: 120)))
    }
}

struct TempoView_Previews: PreviewProvider {
    static var previews: some View {
        BPMView(bpm: 100)
    }
}
