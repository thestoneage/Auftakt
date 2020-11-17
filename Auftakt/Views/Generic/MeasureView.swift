//
//  MeasureView.swift
//  MyMetronome
//
//  Created by Marc Rummel on 30.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct MeasureView: View {
    let measure: Measure
    
    var body: some View {
        Text(measure.description)
    }
}

struct MeasureView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureView(measure: Measure.defaultMeasure)
    }
}
