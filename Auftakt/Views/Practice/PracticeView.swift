//
//  NewPracticeView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 28.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI
enum PracticeSheet: Identifiable {
    case settings
    case measure
    case presets
    case instrument
    
    var id: Int {
        hashValue
    }
}

struct IncrementView: View {
    @Binding var sheet: PracticeSheet?
    @EnvironmentObject var runner: PracticeRunner
    
    var body: some View {
        Button(action: { sheet = .settings }) {
            VStack {
                Text(NSLocalizedString("Increment", comment: "Label for Increment"))
                    .font(.caption)
                Text(Int(runner.practice.tempoIncrement).description)
            }
        }
    }
}


struct RepetitionView: View {
    @Binding var sheet: PracticeSheet?
    @EnvironmentObject var runner: PracticeRunner
    
    var body: some View {
        Button(action: { sheet = .settings }) {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Repetitions", comment: "Label for Repetitions"))
                    .font(.caption)
                Text(runner.practice.repetitions.description)
            }
        }
    }
}

struct LengthView: View {
    @Binding var sheet: PracticeSheet?
    @EnvironmentObject var runner: PracticeRunner
    
    var body: some View {
        Button(action: { sheet = .settings }) {
            VStack(alignment: .trailing) {
                Text(NSLocalizedString("Length", comment: "Label for Length"))
                    .font(.caption)
                Text(runner.practice.bars.description)
            }
        }
    }
}

struct StartView: View {
    @Binding var sheet: PracticeSheet?
    @EnvironmentObject var runner: PracticeRunner
    
    var body: some View {
        Button(action: { sheet = .settings }) {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Start", comment: "Label for Start Tempo"))
                    .font(.caption)
                Text(Int(runner.practice.startTempo).description)
            }
        }
    }
}

struct GoalView: View {
    @Binding var sheet: PracticeSheet?
    @EnvironmentObject var runner: PracticeRunner
    
    var body: some View {
        Button(action: { sheet = .settings }) {
            VStack(alignment: .trailing) {
                Text(NSLocalizedString("Goal", comment: "Label for Goal Tempo"))
                    .font(.caption)
                Text(Int(runner.practice.endTempo).description)
            }
        }
    }
}

struct FourCornersView: View {
    @Binding var sheet: PracticeSheet?
    @EnvironmentObject var runner: PracticeRunner
    
    var body: some View {
        VStack {
            HStack {
                RepetitionView(sheet: $sheet)
                Spacer()
                LengthView(sheet: $sheet)
            }
            Spacer()
            HStack {
                Button(action: { sheet = (.measure) }) {
                    MeasureView(measure: runner.practice.measure)
                }
                Spacer()
                Button(action: { sheet = (.measure) }) {
                    SubdivView(subdiv: runner.practice.measure.subdiv,
                               note: runner.practice.measure.note)
                }
            }
        }
    }
}

struct TopRowView: View {
    @Binding var sheet: PracticeSheet?
    
    var body: some View {
        ZStack {
            Text(NSLocalizedString("Practice", comment: "Title for Practice")).font(.headline)
            Spacer()
            HStack {
                Button(action: { sheet = .instrument }) {
                    Image(systemName: "speaker.wave.2")
                }
                Spacer()
                Button(action: { sheet = .presets }) {
                    Image(systemName: "list.bullet")
                }
            }
        }.padding(.bottom)
    }
}

struct BottomRowView: View {
    @Binding var sheet: PracticeSheet?
    
    var body: some View {
        ZStack {
            IncrementView(sheet: $sheet)
            HStack(alignment: .bottom) {
                StartView(sheet: $sheet)
                Spacer()
                GoalView(sheet: $sheet)
            }
        }
    }
}

struct PracticeView: View {
    @EnvironmentObject var runner: PracticeRunner
    @State var sheet: PracticeSheet?
    
    var body: some View {
        VStack {
            TopRowView(sheet: $sheet)
            ZStack {
                ZStack {
                    RotationalView(practice: $runner.practice,
                                   isRunning: runner.isRunning)
                        .aspectRatio(1.0, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    RunnerView(runner: (runner))
                        .padding(UIScreen.main.bounds.width / 2.8)
                }
                FourCornersView(sheet: $sheet)
            }
            BottomRowView(sheet: $sheet)
            AccentsView(accents: $runner.practice.measure.accents,
                        activeBeatIndex: runner.practice.measure.activeBeatIndex)
        }
        .padding()
        .onDisappear {
            self.runner.stop()
            //runner.saveCurrent()
        }
        .sheet(item: $sheet ) { item in
            switch item {
            case .measure:
                MeasureSettings(beats: $runner.practice.measure.beats,
                                note: $runner.practice.measure.note,
                                subdiv: $runner.practice.measure.subdiv)
            case .settings:
                PracticeSettingsView(practice: $runner.practice)
            case .presets:
                PracticePresetListView(practice: $runner.practice)
            case .instrument:
                InstrumentListView(runner: runner)
            }
        }
        .onChange(of: sheet, perform: { _ in
            runner.stop()
        })
        .environmentObject(runner)
    }
}


struct NewPracticeView_Previews: PreviewProvider {
    static let runner: PracticeRunner = {
        var measure = Measure(beats: .three, note: .quarter)
        measure.accents = [.accent, .normal, .normal]
        let runner = PracticeRunner()
        return runner
    }()
    
    static var previews: some View {
        Group {
            PracticeView().environmentObject(runner)
                .previewDevice(PreviewDevice(rawValue: "iPod touch"))
                .previewDisplayName("iPod touch")
            
            PracticeView().environmentObject(runner)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
            
            PracticeView().environmentObject(runner)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")
            
            PracticeView().environmentObject(runner)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
                .previewDisplayName("iPhone 12 mini")
        }
    }
}

