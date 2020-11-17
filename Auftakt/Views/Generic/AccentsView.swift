//
//  AccentView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 31.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct AccentViewContainer: View {
    @State var accents: [Accent] =  [.normal, .normal, .normal, .normal]
    
    var body: some View {
        AccentsView(accents: $accents, activeBeatIndex: 0)
    }
}

struct AccentsView: View {
    @Binding var accents: [Accent]
    let activeBeatIndex: Int?

    func containedView(idx: Int) -> some View {
        switch self.accents[idx] {
        case .normal:
            return AnyView(NormalView())
        case .accent:
            return AnyView(AccentView())
        case .mute:
            return AnyView(MuteView())
        case .subdiv:
            return AnyView(EmptyView())
        }
    }

    var body: some View {
        HStack {
            ForEach(accents.indices, id: \.self) { idx in
                containedView(idx: idx)
                    .border(activeBeatIndex == idx ? Color.red : Color.clear, width: 4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.accents[idx].cycle()
                }
            }
        }
    }
}

struct AccentView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
    }
}

struct NormalView: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.bgLane)
            Rectangle()
                .foregroundColor(.blue)
        }
    }
}

struct MuteView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.bgLane)
    }
}

struct AccentView_Previews: PreviewProvider {
    static var previews: some View {
        AccentViewContainer()
    }
}
