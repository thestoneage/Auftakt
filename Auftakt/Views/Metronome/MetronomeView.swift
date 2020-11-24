//
//  MetronomeView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 27.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

enum MetronomeViewSheet: Identifiable {
    case presets
    case measure
    case sounds
    
    var id: Int {
        hashValue
    }
}

struct MetronomeView: View {
    @ObservedObject var metronomeRunner: MetronomeRunner
    @State private var sheet: MetronomeViewSheet?
    
    var body: some View {
        VStack {
            ZStack {
                Text(NSLocalizedString("Metronome", comment: "Title of Metronome View")).font(.headline)
                Spacer()
                HStack {
                    Button(action: { sheet = .sounds }) {
                        Image(systemName: "speaker.wave.2")
                    }
                    Spacer()
                    Button(action: { sheet = .presets }) {
                        Image(systemName: "list.bullet")
                    }
                }
            }.padding(.bottom)
            ZStack(alignment: .bottom ) {
                ZStack(alignment: .center) {
                    CircularSlider(min: Tempo.min,
                                   max: Tempo.max,
                                   value: $metronomeRunner.metronome.tempo.bpm)
                        .aspectRatio(1.0, contentMode: .fill)
                    RunnerView(runner: metronomeRunner)
                        .padding(UIScreen.main.bounds.width / 2.6)
                }
                ZStack(alignment: .bottom) {
                    VStack {
                        BPMView(bpm: metronomeRunner.metronome.tempo.bpm)
                        TempusView(tempus: $metronomeRunner.metronome.tempo.tempus)
                    }
                    HStack(alignment: .bottom) {
                        Button(action: { sheet = .measure }) {
                            MeasureView(measure: metronomeRunner.metronome.measure)
                                .font(.title)
                        }
                        Spacer()
                        Button(action: { sheet = .measure }) {
                            SubdivView(subdiv: metronomeRunner.metronome.measure.subdiv,
                                       note: metronomeRunner.metronome.measure.note)
                                .font(.title)
                        }
                    }
                }
            }.padding(.bottom)
            VStack {
                AccentsView(accents: $metronomeRunner.metronome.measure.accents, activeBeatIndex: metronomeRunner.metronome.measure.activeBeatIndex)
                TapTempoView(tempo: $metronomeRunner.metronome.tempo)
            }
        }
        .padding()
        .onDisappear {
            metronomeRunner.saveCurrent()
            self.metronomeRunner.stop()
        }
        .sheet(item: $sheet) { item in
            switch item {
            case .measure:
                MeasureSettings(beats: $metronomeRunner.metronome.measure.beats,
                                note: $metronomeRunner.metronome.measure.note,
                                subdiv: $metronomeRunner.metronome.measure.subdiv)
            case .presets:
                MetronomePresetListView(metronome: $metronomeRunner.metronome)
            case .sounds:
                InstrumentListView(runner: metronomeRunner)
            }
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MetronomeView(metronomeRunner: MetronomeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPod touch"))
                .previewDisplayName("iPod touch")
            
            MetronomeView(metronomeRunner: MetronomeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")

            MetronomeView(metronomeRunner: MetronomeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")

            MetronomeView(metronomeRunner: MetronomeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
                .previewDisplayName("iPhone 12 mini")
            
            MetronomeView(metronomeRunner: MetronomeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 max"))
                .previewDisplayName("iPhone 12 max")

        }
        
    }
}

