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
    private var mockTimer: MockTimer!
    private var mockPlayer: MockPlayer!
    
    override func setUp() async throws {
        try await super.setUp()
        
        mockTimer = MockTimer()
        mockPlayer = MockPlayer()
        sut = .init(timerService: mockTimer, player: mockPlayer)
        state = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        mockTimer = nil
        mockPlayer = nil
        
        try await super.tearDown()
    }
    
    func test_reduceInitialGameState() {
        _ = sut.reduce(&state, action: .gameState(.initial))
        
        XCTAssertEqual(state.gameFlow, .initial)
        XCTAssertEqual(state.title, "Нажмите запустить, чтобы начать игру")
        XCTAssertEqual(state.counter, 0)
    }
    
    func test_reducePlayGameState() {
        _ = sut.reduce(&state, action: .gameState(.play))
       
        XCTAssertEqual(state.gameFlow, .play)
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(mockPlayer.isRequestSend)
    }
    
    func test_reducePauseGameState() {
        _ = sut.reduce(&state, action: .gameState(.pause))
        
        XCTAssertEqual(state.gameFlow, .pause)
        XCTAssertEqual(state.title, "Пауза...")
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(mockPlayer.isRequestSend)
    }
    
    func test_reduceGameOverState() {
        state.punishmentArr = ["Baz", "Bar"]
        sut = .init(
            timerService: mockTimer,
            player: mockPlayer,
            randomNumber: { _ in 1 }
        )
        
        _ = sut.reduce(&state, action: .gameState(.gameOver))
        
        XCTAssertEqual(state.gameFlow, .gameOver)
        XCTAssertEqual(state.title, "Конец игры")
        XCTAssertEqual(state.punishment, "Bar")
        XCTAssertTrue(mockPlayer.isRequestSend)
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(state.isShowSheet)
    }
    
    func test_launchButtonChangeGameStateToPlay() {
        let spy = StateSpy(
            sut.reduce(&state, action: .launchButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.play))
    }
    
    func test_timerTickEmitReducerAction() {
        let spy = StateSpy(
            sut.reduce(&state, action: .viewAppeared)
        )
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.gameState(.initial), .timerTicked])
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.gameState(.initial), .timerTicked, .timerTicked])
    }
    
    func test_timerTickActionIncreaseCounter() {
        state.counter = 0
        
        _ = sut.reduce(&state, action: .timerTicked)
        
        XCTAssertEqual(state.counter, 1)
        
        _ = sut.reduce(&state, action: .timerTicked)
        
        XCTAssertEqual(state.counter, 2)
    }
    
    func test_timerTickActionEmitGameOverState() {
        state.counter = 30
        let spy = StateSpy(
            sut.reduce(&state, action: .timerTicked)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.gameOver))
    }
    
    func test_pauseButtonTapEmitPauseGameState() {
        let spy = StateSpy(
            sut.reduce(&state, action: .pauseButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.pause))
    }
    
    func test_playAgainButtonTapEmitSetupGameAction() {
        let spy = StateSpy(
            sut.reduce(&state, action: .playAgainButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.initial))
    }
    
    func test_anotherPunishmentButtonTap() {
        sut = .init(randomNumber: {_ in 1 })
        state.punishment = "Baz"
        state.punishmentArr = ["Baz", "Bar"]
        
        _ = sut.reduce(&state, action: .anotherPunishmentButtonTap)
        
        XCTAssertEqual(state.punishment, "Bar")
    }
    
    func test_reduceDismissSheetAction() {
        state.isShowSheet = true
        
        _ = sut.reduce(&state, action: .dismissSheet)
        
        XCTAssertFalse(state.isShowSheet)
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
    
    func playTicking() {
        isRequestSend = true
    }
    
    func playBlow() {
        isRequestSend = true
    }
    
    func stop() {
        isRequestSend = true
    }
}

final class StateSpy<A: Equatable> {
    private var cancellable: Set<AnyCancellable> = .init()
    
    private(set) var actions: [A] = .init()
    
    init(_ publishers: AnyPublisher<A, Never>...) {
        Publishers.MergeMany(publishers)
            .sink { self.actions.append($0) }
            .store(in: &cancellable)
    }
}
