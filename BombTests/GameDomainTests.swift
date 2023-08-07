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
    
    func test_initialState() {
        _ = sut.reduce(&state, action: .viewAppeared)
        
        XCTAssertEqual(state.title, "Нажмите запустить, чтобы начать игру")
        XCTAssertEqual(state.gameState, .initial)
    }

    func test_launchButtonTapStartsTimer() {
        _ = sut.reduce(&state, action: .launchButtonTap)
       
        XCTAssertTrue(mockTimer.isRequestSend)
    }
    
    func test_launchButtonStartsAudioPlay() {
        _ = sut.reduce(&state, action: .launchButtonTap)
        
        XCTAssertTrue(mockPlayer.isRequestSend)
    }
    
    func test_launchButtonChangeGameStateToPlay() {
        _ = sut.reduce(&state, action: .launchButtonTap)
        
        XCTAssertEqual(state.gameState, .play)
    }
    
    func test_timerTickEmitReducerAction() {
        let spy = StateSpy(publisher: sut.reduce(&state, action: .viewAppeared))
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.timerTicked])
    }
    
    func test_timerTickActionIncreaseCounter() {
        state.counter = 0
        
        _ = sut.reduce(&state, action: .timerTicked)
        
        XCTAssertEqual(state.counter, 1)
    }
    
    func test_timerTickActionEmitGameOverState() {
        state.counter = 30
        
        _ = sut.reduce(&state, action: .timerTicked)
            .sink(receiveValue: { [unowned self] action in
                exp.fulfill()
                XCTAssertEqual(action, .gameOver)
            })
        
        wait(for: [exp], timeout: 0.1)
    }
}

final class MockTimer: TimerProtocol {
    let timerTick: PassthroughSubject<Date, Never> = .init()
    private(set) var isRequestSend = false
    
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
    private(set) var isRequestSend = false
    
    func play() {
        isRequestSend = true
    }
    
    func stop() {
        isRequestSend = true
    }
}

final class StateSpy {
    private var cancellable: Set<AnyCancellable> = .init()
    
    private(set) var actions: [GameDomain.Action] = .init()
    
    init(publisher: AnyPublisher<GameDomain.Action, Never>) {
        publisher
            .sink { [unowned self] action in
                actions.append(action)
            }
            .store(in: &cancellable)
    }
}
