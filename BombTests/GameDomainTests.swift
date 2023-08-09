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
    private var spy: StateSpy<GameDomain.Action>!
    
    override func setUp() async throws {
        try await super.setUp()
        
        mockTimer = MockTimer()
        mockPlayer = MockPlayer()
        sut = .init(timerService: mockTimer, player: mockPlayer)
        state = .init()
        spy = .init()
    }
    
    override func tearDown() async throws {
        sut = nil
        state = nil
        mockTimer = nil
        mockPlayer = nil
        spy = nil
        
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
        spy.schedule(
            sut.reduce(&state, action: .launchButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.play))
    }
    
    func test_timerTickEmitReducerAction() {
        spy.schedule(
            sut.reduce(&state, action: .viewAppeared)
        )
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.gameState(.initial), .timerTick])
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.gameState(.initial), .timerTick, .timerTick])
    }
    
    func test_timerTickActionIncreaseCounter() {
        state.counter = 0
        state.estimatedTime = 10
        
        spy.schedule(
            sut.reduce(&state, action: .timerTick),
            sut.reduce(&state, action: .timerTick),
            sut.reduce(&state, action: .timerTick)
        )
       
        XCTAssertEqual(state.counter, 3)
    }
    
    func test_timerTickActionEmitGameOverState() {
        state.counter = 30
        spy.schedule(
            sut.reduce(&state, action: .timerTick)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.gameOver))
    }
    
    func test_pauseButtonTapEmitPauseState() {
        state.gameFlow = .play
        
        spy.schedule(
            sut.reduce(&state, action: .pauseButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.pause))
    }
    
    func test_pauseButtonTapEmitPlayState() {
        state.gameFlow = .pause
        
        spy.schedule(
            sut.reduce(&state, action: .pauseButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .gameState(.play))
    }
    
    func test_pauseButtonTapDoesntEmitActions() {
        spy.schedule(
            sut.reduce(&state, action: .pauseButtonTap)
        )
        
        XCTAssertTrue(spy.actions.isEmpty)
    }
    
    func test_playAgainButtonTapEmitSetupGameAction() {
        spy.schedule(
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
    let exp = XCTestExpectation(description: "StateSpy")
    private(set) var actions: [A] = .init()
    
    init() { }
    
    func schedule(_ publishers: AnyPublisher<A, Never>...) {
        Publishers.MergeMany(publishers)
            .sink { _ in
                self.exp.fulfill()
            } receiveValue: { action in
                self.actions.append(action)
            }
            .store(in: &cancellable)
    }
}
