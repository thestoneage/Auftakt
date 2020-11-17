//
//  Runner.swift
//  MyMetronome
//
//  Created by Marc Rummel on 30.10.20.
//  Copyright © 2020 Marc Rummel. All rights reserved.
//

import Foundation
import Combine
import AVFoundation
import SwiftUI

protocol Runable: ObservableObject {
    var isRunning:Bool {get}
    func start() -> ()
    func stop() -> ()
}

protocol Tickable: AnyObject {
    var countIn: Bool { get }
    var measure: Measure { get set }
    var instrument: Instrument { get set }
    var bpm: Double { get }
    var isRunning: Bool { get set }
    func fireBar() -> ()
}

extension AVAudioPlayer {
    func trigger() -> () {
        self.currentTime = 0
        self.play()
    }
}

class Runner {
    var timer: Timer?
    weak var delegate: Tickable?
    
    var sound: Sounds = Sounds.tamborine {
        didSet {
            accentPlayer = try! AVAudioPlayer(contentsOf: sound.accent!)
            normalPlayer = try! AVAudioPlayer(contentsOf: sound.normal!)
            subdivPlayer = try! AVAudioPlayer(contentsOf: sound.subdiv!)
            beepPlayer = try! AVAudioPlayer(contentsOf: sound.beep!)
        }
    }
    var accentPlayer: AVAudioPlayer!
    var subdivPlayer: AVAudioPlayer!
    var normalPlayer: AVAudioPlayer!
    var beepPlayer: AVAudioPlayer!
        
    init() {
        defer {
            sound = Sounds.wood
        }
    }
    
    func start()  {
        self.timer = Timer(timeInterval: 0.004,
                           target: self, selector: #selector(fire),
                           userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
        delegate?.isRunning = true
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func stop() {
        guard let timer = timer else { return  }
        timer.invalidate()
        delegate?.isRunning = false
        delegate?.measure.reset()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    internal func fireSubdiv()  {
        guard let delegate = delegate else { return }
        if delegate.countIn {
            beepPlayer.trigger()
            return
        }
        switch delegate.measure.currentAccent {
        case .normal:
            normalPlayer.trigger()
        case .accent:
            accentPlayer.trigger()
        case .mute:
            break
        case .subdiv:
            normalPlayer.trigger()
        case nil:
            break
        }
    }
    
    var lastFire: TimeInterval = Date.timeIntervalSinceReferenceDate
    @objc func fire() {
        guard let delegate = delegate else { return  }
        let now = Date.timeIntervalSinceReferenceDate
        let difference = now - lastFire
        let interval = 60.0 / (delegate.bpm * delegate.measure.subdiv.rawValue)
        if difference > interval {
            lastFire = now
            delegate.measure.tickSubdiv()
            if delegate.measure.isAtStartOfBar {
                delegate.fireBar()
            }
            self.fireSubdiv()
        }
    }
}

