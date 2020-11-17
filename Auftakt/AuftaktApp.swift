//
//  AuftaktApp.swift
//  Auftakt
//
//  Created by Marc Rummel on 17.11.20.
//

import SwiftUI

@main
struct AuftaktApp: App {
    let practiceRunner = PracticeRunner()
    let metronomeRunner = MetronomeRunner()
    
    var body: some Scene {
        WindowGroup {
            ContentView(mainRunner: metronomeRunner,
                        practiceRunner: practiceRunner)
        }
    }
}
