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
    private var spy: Spy<GameDomain.Action>!
    
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
        state.counter = 10
        state.isShowSheet = true
        state.title = "Baz"
        
        _ = sut.reduce(&state, action: .setGameState(.initial))
        
        XCTAssertEqual(state.gameFlow, .initial)
        XCTAssertEqual(state.title, "Нажмите запустить, чтобы начать игру")
        XCTAssertEqual(state.counter, 0)
        XCTAssertFalse(state.isShowSheet)
    }
    
    func test_reducePlayGameState() {
        _ = sut.reduce(&state, action: .setGameState(.play))
       
        XCTAssertEqual(state.gameFlow, .play)
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(mockPlayer.isPlayTicking)
        XCTAssertTrue(mockPlayer.isPlayBackgroundMusic)
        XCTAssertFalse(state.isShowSheet)
    }
    
    func test_reducePauseGameState() {
        _ = sut.reduce(&state, action: .setGameState(.pause))
        
        XCTAssertEqual(state.gameFlow, .pause)
        XCTAssertEqual(state.title, "Пауза...")
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(mockPlayer.isStopSend)
        XCTAssertFalse(state.isShowSheet)
    }
    
    func test_reduceGameOverState() {
        state.questsArray = ["Baz", "Bar"]
        sut = .init(
            timerService: mockTimer,
            player: mockPlayer,
            randomNumber: { _ in 1 }
        )
        
        _ = sut.reduce(&state, action: .setGameState(.gameOver))
        
        XCTAssertEqual(state.gameFlow, .gameOver)
        XCTAssertEqual(state.title, "Конец игры")
        XCTAssertEqual(state.quest, "Bar")
        XCTAssertTrue(mockPlayer.isPlayBlow)
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(state.isShowSheet)
    }
    
    func test_launchButtonTapModifiesStateWithSettings() {
        let testSettings = Settings(
            duration: .short,
            backgroundMelody: .melody3,
            tickSound: .melody3,
            explosionSound: .melody3,
            vibrationEnabled: true,
            questionsEnabled: false
        )
        
        _ = sut.reduce(&state, action: .launchButtonTap(testSettings))
        
        XCTAssertEqual(state.estimatedTime, testSettings.duration.duration)
        XCTAssertEqual(state.backgroundMelody, testSettings.backgroundMelody)
        XCTAssertEqual(state.tickSound, testSettings.tickSound)
        XCTAssertEqual(state.explosionSound, testSettings.explosionSound)
    }
    
    func test_launchButtonChangeGameStateToPlay() {
        spy.schedule(
            sut.reduce(&state, action: .launchButtonTap(.init()))
        )
        
        XCTAssertEqual(spy.actions.first, .setGameState(.play))
    }
    
    func test_setupGameSubscribeToTimer() {
        spy.schedule(
            sut.reduce(&state, action: .setupGame)
                .dropFirst()
                .eraseToAnyPublisher()
        )
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.timerTick])
        
        mockTimer.sendTick()
        
        XCTAssertEqual(spy.actions, [.timerTick, .timerTick])
    }
    
    func test_setupGameSendGameState() {
        state.gameFlow = .play
        
        spy.schedule(
            sut.reduce(&state, action: .setupGame)
        )
        
        XCTAssertEqual(spy.actions.first, .setGameState(.play))
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
        
        XCTAssertEqual(spy.actions.first, .setGameState(.gameOver))
    }
    
    func test_pauseButtonTapEmitPauseState() {
        state.gameFlow = .play
        
        spy.schedule(
            sut.reduce(&state, action: .pauseButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .setGameState(.pause))
    }
    
    func test_pauseButtonTapEmitPlayState() {
        state.gameFlow = .pause
        
        spy.schedule(
            sut.reduce(&state, action: .pauseButtonTap)
        )
        
        XCTAssertEqual(spy.actions.first, .setGameState(.play))
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
        
        XCTAssertEqual(spy.actions.first, .setGameState(.initial))
    }
    
    func test_anotherPunishmentButtonTap() {
        sut = .init(randomNumber: {_ in 1 })
        state.quest = "Baz"
        state.questsArray = ["Baz", "Bar"]
        
        _ = sut.reduce(&state, action: .anotherPunishmentButtonTap)
        
        XCTAssertEqual(state.quest, "Bar")
    }
    
    func test_reduceDismissSheetAction() {
        state.isShowSheet = true
        
        _ = sut.reduce(&state, action: .dismissSheet)
        
        XCTAssertFalse(state.isShowSheet)
    }
    
    func test_reduceViewDisappear() {
        _ = sut.reduce(&state, action: .viewDisappear)
        
        XCTAssertTrue(mockTimer.isRequestSend)
        XCTAssertTrue(mockPlayer.isStopSend)
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
    private(set) var isStopSend = false
    private(set) var isPlayTicking = false
    private(set) var isPlayBlow = false
    private(set) var isPlayBackgroundMusic = false
    
    func playTicking(_ melody: Settings.Melody) {
        isPlayTicking = true
    }
    
    func playExplosion(_ melody: Settings.Melody) {
        isPlayBlow = true
    }
    
    func stop() {
        isStopSend = true
    }
    
    func playBackgroundMusic(_ melody: Settings.Melody) {
        isPlayBackgroundMusic = true
    }
    
}

