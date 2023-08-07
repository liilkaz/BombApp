//
//  GameDomainTests.swift
//  BombTests
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import XCTest
import Combine

@testable import Bomb

final class GameDomainTests: XCTestCase {
    private var sut: GameDomain!
    private var state: GameDomain.State!
    private var exp: XCTestExpectation!
    private var mockTimer: MockTimer!
    private var mockPlayer: MockPlayer!
    
    override func setUp() async throws {
        try await super.setUp()
        
        mockTimer = MockTimer()
        mockPlayer = MockPlayer()
        sut = .init(timerService: mockTimer, player: mockPlayer)
        state = .init()
        exp = .init(description: "GameDomainTests")
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        exp = nil
        mockTimer = nil
        mockPlayer = nil
        
        try await super.tearDown()
    }

    func test_launchButtonTapStartsTimer() {
        _ = sut.reduce(&state, action: .launchButtonTap)
       
        XCTAssertTrue(mockTimer.isRequestSend)
    }
    
    func test_launchButtonStartsAudioPlay() {
        _ = sut.reduce(&state, action: .launchButtonTap)
        
        XCTAssertTrue(mockPlayer.isRequestSend)
    }
    
    func test_timerTickEmitReducerAction() {
        let spy = StateSpy(publisher: sut.reduce(&state, action: .viewAppeared))
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.timerTicked])
    }
    
    
}

final class MockTimer: TimerProtocol {
    let timerTick: PassthroughSubject<Date, Never> = .init()
    var isRequestSend = false
    
    func startTimer() {
        isRequestSend = true
    }
    
    func stopTimer() {
        isRequestSend = true
    }
    
    func sendTick() {
        timerTick.send(.now)
    }
}

final class MockPlayer: AudioPlayerProtocol {
    var isRequestSend = false
    
    func play() {
        isRequestSend = true
    }
    
    func stop() {
        isRequestSend = true
    }
}

final class StateSpy {
    private var cancellable: Set<AnyCancellable> = .init()
    
    var actions: [GameDomain.Action] = .init()
    
    init(publisher: AnyPublisher<GameDomain.Action, Never>) {
        publisher
            .sink{ [unowned self] action in
                actions.append(action)
            }
            .store(in: &cancellable)
    }
}
