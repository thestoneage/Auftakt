//
//  Extensions.swift
//  MyMetronome
//
//  Created by Marc Rummel on 28.08.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation

extension Array: RawRepresentable
where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data)
        else { return nil }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
              else { return "[]" }
        return result
    }
}


protocol Cyclable: CaseIterable, Equatable {
    var cyclableCases: [Self] { get }
    var cycled: Self { get }

    mutating func cycle() -> ()
}

protocol Neighboring: CaseIterable, Equatable {
    var next: Self? { get }
    var prev: Self? { get }
}

extension Cyclable {

    var cyclableCases: [Self] {
        return Array(Self.allCases)
    }

    var cycled: Self {
        let cases = cyclableCases
        let indexOfSelf = cases.firstIndex(of: self)!
        let next = cases.index(after: indexOfSelf)
        if cases.indices.contains(next) {
            return cases[next]
        }
        return cases.first!
    }

    mutating func cycle() {
        self = cycled
    }
}

extension Neighboring {
    private var all: [Self] {
        Array(Self.allCases)
    }

    private var indexOfSelf: Int {
        return all.firstIndex(of: self)!
    }

    private func casus(at index: Int) -> Self? {
        guard all.indices.contains(index) else { return nil }
        return all[index]
    }

    var next: Self? {
        let nextIndex = all.index(after: indexOfSelf)
        return casus(at: nextIndex)
    }

    var prev: Self? {
        let prevIndex = all.index(before: indexOfSelf)
        return casus(at: prevIndex)
    }

    var hasNext: Bool {
        return next != nil
    }

    var hasPrev: Bool {
        return prev != nil
    }

    mutating func increment() {
        if let inc = next {
            self = inc
        }
    }

    mutating func decrement() {
        if let dec = prev {
            self = dec
        }
    }
}

extension Double {
    func clamped(lowerBound: Double, upperBound: Double) -> Double {
        return max(min(self, upperBound), lowerBound)
    }
}

import SwiftUI
extension Color {
    static var bgLane: Color {
        return Color.gray
            .opacity(0.3)
    }
}
