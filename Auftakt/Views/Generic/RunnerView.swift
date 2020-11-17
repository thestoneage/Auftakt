//
//  RunnerView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 04.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct RunnerView<T>: View where T: Runable {
    @ObservedObject var runner: T
    @ScaledMetric var fontsize: CGFloat = 60

    var body: some View {
        Button(action: {
            if self.runner.isRunning {
                self.runner.stop()
            }
            else {
                self.runner.start()
            }
        }) {
            if runner.isRunning {
                Image(systemName: "stop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else {
                Image(systemName: "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }

    }
}

struct RunnerView_Previews: PreviewProvider {
    static var previews: some View {
        RunnerView(runner: MetronomeRunner())
    }
}
