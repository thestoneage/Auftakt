//
//  SubdivView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 11.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct SubdivView: View {
    let subdiv: Subdiv
    let note: Note
    
    var body: some View {
        Image(uiImage:
                UIImage(named: subdiv.name(with: note),
                        in: nil,
                        with:  UIImage.SymbolConfiguration(pointSize: 28))!)
            .renderingMode(.template)
            .foregroundColor(.blue)
    }
}

struct SubdivView_Previews: PreviewProvider {
    static var previews: some View {
        SubdivView(subdiv: .double, note: .quarter)
    }
}

