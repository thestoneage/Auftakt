//
//  AuftaktApp.swift
//  Auftakt
//
//  Created by Marc Rummel on 17.11.20.
//

import SwiftUI
import AVFoundation

@main
struct AuftaktApp: App {
    let practiceRunner = PracticeRunner()
    let metronomeRunner = MetronomeRunner()
    
    init() {
        let sharedSession = AVAudioSession.sharedInstance()
        try? sharedSession.setCategory(.playback)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(mainRunner: metronomeRunner,
                        practiceRunner: practiceRunner)
        }
    }
}
