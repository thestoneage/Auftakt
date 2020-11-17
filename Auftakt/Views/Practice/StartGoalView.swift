//
//  CircularSlider.swift
//  MyMetronome
//
//  Created by Marc Rummel on 15.09.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import SwiftUI

struct PracticeSlidersSettings {
    static let strokeWidth: CGFloat = UIScreen.main.bounds.width / 20.0 //16.0
    static let knobRadius: CGFloat = UIScreen.main.bounds.width / 10.0 //32
}

struct Arc {
    let start: CGFloat
    let end: CGFloat
    var length: CGFloat {
        return end - start
    }
    var startAngle: Double {
        return Double(start * 2.0 * .pi)
    }
}

struct Increment: Identifiable {
    var bpm: Double
    let start: CGFloat
    let end: CGFloat
    
    var id = UUID()
}

struct StartGoalView: View {

    private let settings = PracticeSlidersSettings.self

    let minBPM: Double = Tempo.min
    let maxBPM: Double = Tempo.max
    
    let gapLength:CGFloat = 0.003

    @Binding var start: Double
    @Binding var goal: Double
    @Binding var increment: Double

    let minInc: Double = 1.0
    var maxInc: Double {
        goal - start
    }

    var valueArc = Arc(start: 0.0, end: 0.75)
    var incArc = Arc(start: 0.77, end: 0.98)

    let current: Double
    let practiceRunning: Bool

    var incrementStarts: [Increment] {
        let diff = goal - start
        let div = (diff / increment)
        let times = Int(div)
        let a: [Increment] = Array(0...times).map {
            let start = self.start + increment * Double($0)
            let startRatio = ratio(from: start, min: minBPM, max: maxBPM, arc: valueArc)
            let end = min(start + increment, self.goal)
            let endRatio = ratio(from: end, min: minBPM, max: maxBPM, arc: valueArc)
            return Increment(bpm: start, start: CGFloat(startRatio), end: CGFloat(endRatio))
        }
        return a
    }

    func value(ratio: CGFloat, minValue: CGFloat, maxValue: CGFloat, arc: Arc) -> CGFloat {
        let v = ratio * (maxValue - minValue) / arc.length + minValue
        return v
    }

    func value(angle: CGFloat, minValue: CGFloat, maxValue: CGFloat, arc:Arc) -> CGFloat {
        let ratio = angle / (.pi * 2.0)
        return value(ratio: ratio, minValue: minValue, maxValue: maxValue, arc: arc)
    }

    func angle(from location: CGPoint) -> CGFloat {
        let angle = atan2(location.y, location.x)
        return angle < 0.0 ? angle + 2.0 * .pi : angle
    }

    func rotation(from value: Double, min: Double, max: Double, arc: Arc) -> Double {
        ratio(from: value, min: min, max: max, arc: arc) * 2.0 * .pi
    }

    func ratio(from value: Double, min: Double, max: Double, arc: Arc) -> Double {
        ((value - min) / (max - min)) * Double(arc.length)
    }

    func radius(_ geometry: GeometryProxy) -> CGFloat {
        return Swift.min(geometry.size.width, geometry.size.height)/2.0
    }

    func changeStart(location: CGPoint) {
        let absAngle = angle(from: location)
        let relAngle = absAngle - CGFloat(valueArc.startAngle)
        let unbound = value(angle: relAngle, minValue: CGFloat(minBPM), maxValue: CGFloat(maxBPM), arc: valueArc)
        start = min(Double(unbound.rounded()), goal)
        increment = max(min(increment.rounded(), maxInc),minInc)
    }

    func changeGoal(location: CGPoint) {
        let absAngle = angle(from: location)
        let relAngle = absAngle - CGFloat(valueArc.startAngle)
        let unbound = value(angle: relAngle, minValue: CGFloat(minBPM), maxValue: CGFloat(maxBPM), arc: valueArc)
        goal = max(Double(unbound.rounded()), start)
        increment = max(min(increment.rounded(), maxInc),minInc)
    }

    func changeIncrement(location: CGPoint) {
        let absAngle = angle(from: location)
        let relAngle = absAngle - CGFloat(incArc.startAngle)
        let unbound = value(angle: relAngle,
                               minValue: CGFloat(minInc),
                               maxValue: CGFloat(maxInc),
                               arc: incArc)
        increment = min(max(Double(unbound.rounded()), minInc),maxInc)
    }


    var body: some View {
        GeometryReader { geom in
            ZStack(alignment: .center) {
                LaneView(arc: valueArc, settings: settings)
                LaneView(arc: incArc, settings: settings)
                ForEach(incrementStarts) { incStart in
                    Circle()
                        .trim(from: incStart.start, to: (incStart.end - gapLength))
                        .stroke(lineWidth: settings.strokeWidth)
                        .foregroundColor(current == incStart.bpm ? .red:.blue)
                }
                Circle()
                    .fill(Color.red)
                    .frame(width: settings.knobRadius, height: settings.knobRadius)
                    .offset(x: self.radius(geom))
                    .rotationEffect(.radians(valueArc.startAngle))
                    .rotationEffect(.radians(rotation(from: goal, min: minBPM, max: maxBPM, arc: valueArc)))
                    .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
                                .onChanged({ drag in
                                            self.changeGoal(location: drag.location)}))
                Circle()
                    .fill(Color.blue)
                    .frame(width: settings.knobRadius, height: settings.knobRadius)
                    .offset(x: self.radius(geom))
                    .rotationEffect(.radians(valueArc.startAngle))
                    .rotationEffect(.radians(rotation(from: start, min: minBPM, max: maxBPM, arc: valueArc)))
                    .gesture(DragGesture(minimumDistance: 0.5, coordinateSpace: .local)
                                .onChanged({ drag in
                                            self.changeStart(location: drag.location)}))
                Circle()
                    .fill(Color.green)
                    .frame(width: settings.knobRadius, height: settings.knobRadius)
                    .offset(x: self.radius(geom))
                    .rotationEffect(.radians(incArc.startAngle))
                    .rotationEffect(.radians(
                        rotation(from: increment, min: minInc, max: maxInc, arc: incArc)
                    ))
                    .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
                                .onChanged({ drag in
                                            self.changeIncrement(location: drag.location)}))
            }
        }
        .foregroundColor(.blue)
        .rotationEffect(.init(degrees: 135))
        .padding(settings.strokeWidth/2)
    }
}

struct LaneView: View {
    let arc: Arc
    let settings: PracticeSlidersSettings.Type

    var body: some View {
        Circle()
            .trim(from: arc.start, to: arc.end)
            .stroke(lineWidth: settings.strokeWidth)
            .foregroundColor(.bgLane)
    }
}

struct StartGoald_Previews: PreviewProvider {
    static var previews: some View {
        StartGoalView(start: .constant(60), goal: .constant(120), increment: .constant(20), current: 60, practiceRunning: false)
    }
}
