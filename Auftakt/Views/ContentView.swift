//
//  ContentView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 09.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mainRunner: MetronomeRunner
    @ObservedObject var practiceRunner: PracticeRunner
    
    var body: some View {
        TabView {
            MetronomeView(metronomeRunner: mainRunner)
                .tabItem() {
                    Image(systemName: "wand.and.rays")
                    Text("Metronome")
                }
            PracticeView()
                .environmentObject(practiceRunner)
                .tabItem() {
                    Image(systemName: "goforward.plus")
                    Text("Practice")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(mainRunner: MetronomeRunner(),
                        practiceRunner: PracticeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPod touch"))
                .previewDisplayName("iPod touch")

            ContentView(mainRunner: MetronomeRunner(),
                        practiceRunner: PracticeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")

            ContentView(mainRunner: MetronomeRunner(),
                        practiceRunner: PracticeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 max"))
                .previewDisplayName("iPhone 12 max")
            
            ContentView(mainRunner: MetronomeRunner(),
                        practiceRunner: PracticeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")
            
            ContentView(mainRunner: MetronomeRunner(),
                        practiceRunner: PracticeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
                .previewDisplayName("iPhone 12 mini")

            
            ContentView(mainRunner: MetronomeRunner(),
                        practiceRunner: PracticeRunner())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")

        }

        
    }
}
