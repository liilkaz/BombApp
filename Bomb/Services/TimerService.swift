//
//  TimerService.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import Foundation
import Combine

protocol TimerProtocol: AnyObject {
    var timerTick: PassthroughSubject<Date, Never> { get }
    
    func startTimer()
    func stopTimer()
}

final class TimerService: TimerProtocol {
    private var cancelable: Cancellable?
    
    let timerTick = PassthroughSubject<Date, Never>()
    
    func startTimer() {
        cancelable = Timer
            .publish(every: 1, on: .main, in: .default)
            .sink(receiveValue: timerTick.send(_:))
    }
    
    func stopTimer() {
        cancelable?.cancel()
    }
}
