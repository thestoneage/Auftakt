//
//  CircularSlider.swift
//  MyMetronome
//
//  Created by Marc Rummel on 15.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct CircularSlider: View {
    private let strokeWidth: CGFloat = UIScreen.main.bounds.width / 12.5
    private let knobRadius: CGFloat = UIScreen.main.bounds.width / 9.0
    private let arc: CGFloat = 0.75

    let min: Double
    let max: Double

    @Binding var value: Double

    var valueRatio: CGFloat {
        CGFloat((Double(value) - min)/(max-min)) * arc
    }

    func angle(from location: CGPoint) -> CGFloat {
        let angle = atan2(location.y, location.x)
        return angle < 0.0 ? angle + 2.0 * .pi : angle
    }

    var angle: Double {
        return Double(valueRatio) * 2 * .pi
    }

    func value(from angle: CGFloat) -> Double {
        guard angle < (arc + ((1.0 - arc) / 2.0)) * 2.0 * .pi else {
            return min
        }
        let unbound = Double((angle) / (arc * .pi * 2)) * (max - min) + min
        return Swift.max(Swift.min(unbound, max), min)
    }

    func radius(_ geometry: GeometryProxy) -> CGFloat {
        return Swift.min(geometry.size.width, geometry.size.height) / 2.0
    }

    func change(location: CGPoint) {
        let angle = self.angle(from: location)
        self.value = self.value(from: angle).rounded()
    }

    var body: some View {
        GeometryReader { geom in
            ZStack(alignment: .center) {
                Circle()
                    .trim(from: 0, to: self.arc)
                    .stroke(lineWidth: self.strokeWidth)
                    .foregroundColor(Color.bgLane)
                    .frame(width: geom.size.width, height: geom.size.height, alignment: .center)
                Circle()
                    .trim(from: 0.0, to: self.valueRatio)
                    .stroke(lineWidth: self.strokeWidth)
                    .frame(width: geom.size.width, height: geom.size.height, alignment: .center)
                Circle()
                    .fill(Color.blue)
                    .frame(width: self.knobRadius, height: self.knobRadius)
                    .offset(x: self.radius(geom))
                    .rotationEffect(.radians(self.angle))
                    .gesture(DragGesture(minimumDistance: 0.0)
                                .onChanged({ drag in
                                    self.change(location: drag.location)
                                }))
            }.foregroundColor(.blue)
        }
        .rotationEffect(.init(degrees: 135))
        .padding(strokeWidth / 2.0)
    }
}

struct CircularSliderContainer: View {
    @State var value: Double = 12

    var body: some View {
        CircularSlider(min: 60.0, max: 120.0, value: $value)
    }

}

struct CircularSlider_Previews: PreviewProvider {
    static var previews: some View {
        CircularSliderContainer()
    }
}
