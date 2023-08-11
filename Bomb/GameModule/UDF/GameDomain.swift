//
//  GameDomain.swift
//  Bomb
//
//  Created by Илья Шаповалов on 07.08.2023.
//

import Foundation
import Combine
import OSLog

struct GameDomain {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    //MARK: - State
    struct State: Equatable, Codable {
        var title: String = "Нажмите запустить, чтобы начать игру"
        var quest: String = .init()
        var questsArray: [String] = ["Who are you?", "Fuck off."]
        var counter: Int = .init()
        var estimatedTime: Int = 10
        var gameFlow: GameFlow = .init()
        var backgroundMelody: Settings.Melody = .melody1
        var tickSound: Settings.Melody = .melody1
        var explosionSound: Settings.Melody = .melody1
        var isShowSheet = false
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case setupGame
        case setGameState(State.GameFlow)
        case launchButtonTap(Settings)
        case pauseButtonTap
        case timerTick
        case playAgainButtonTap
        case anotherPunishmentButtonTap
        case dismissSheet
        case viewDisappear
    }
    
    //MARK: - Dependencies
    private let timerService: TimerProtocol
    private let player: AudioPlayerProtocol
    private let randomNumber: (Int) -> Int
    
    //MARK: - init(_:)
    init(
        timerService: TimerProtocol = TimerService(),
        player: AudioPlayerProtocol = AudioPlayer(),
        randomNumber: @escaping (Int) -> Int = { Int.random(in: 0..<$0) }
    ) {
        self.timerService = timerService
        self.player = player
        self.randomNumber = randomNumber
        
        logger.debug("Initialized")
    }
    
    //MARK: - Reducer
    func reduce(_ state: inout State, action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .setupGame:
            let currentState = state
            logger.debug("Setup game. Current state: \(String(reflecting: currentState))")
            
            return Publishers.Concatenate(
                prefix: Just(Action.setGameState(state.gameFlow)),
                suffix: timerService.timerTick.map { _ in .timerTick }
            )
            .eraseToAnyPublisher()
            
        case .setGameState(.initial):
            logger.debug("Setup game state to initial")
            state.counter = 0
            state.isShowSheet = false
            state.title = "Нажмите запустить, чтобы начать игру"
            player.stop()
            state.gameFlow = .initial
            
        case .setGameState(.play):
            logger.debug("Setup game state to play")
            player.playTicking()
            player.playBackgroundMusic()
            timerService.startTimer()
            state.gameFlow = .play
            
        case .setGameState(.pause):
            logger.debug("Setup game state to pause")
            player.stop()
            timerService.stopTimer()
            state.gameFlow = .pause
            state.title = "Пауза..."
            
        case .setGameState(.gameOver):
            logger.debug("Setup game state to gameOver")
            timerService.stopTimer()
            player.playBlow()
            state.gameFlow = .gameOver
            state.title = "Конец игры"
            state.quest = getRandomElement(from: state.questsArray)
            state.isShowSheet = true
            
        case .timerTick:
            guard state.counter < state.estimatedTime else {
                return Just(.setGameState(.gameOver))
                    .eraseToAnyPublisher()
            }
            state.counter += 1
            
        case let .launchButtonTap(settings):
            state.estimatedTime = settings.duration.duration
            state.backgroundMelody = settings.backgroundMelody
            state.tickSound = settings.tickSound
            state.explosionSound = settings.explosionSound
            
            return Just(.setGameState(.play))
                .eraseToAnyPublisher()
            
        case .pauseButtonTap:
            return Just(state)
                .map(\.gameFlow)
                .map(togglePause)
                .compactMap { $0 }
                .eraseToAnyPublisher()
            
        case .playAgainButtonTap:
            return Just(.setGameState(.initial))
                .eraseToAnyPublisher()
            
        case .anotherPunishmentButtonTap:
            state.quest = getRandomElement(from: state.questsArray)
            
        case .viewDisappear:
            timerService.stopTimer()
            player.stop()
            
            return Just(.setGameState(.initial))
                .eraseToAnyPublisher()
            
        case .dismissSheet:
            state.isShowSheet = false
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - Live store
    static let liveStore = GameStore(
        initialState: Self.State(),
        reducer: Self()
    )
    
    //MARK: - Preview stores
    static let previewStoreInitialState = GameStore(
        initialState: Self.State(
            title: "Нажмите запустить, чтобы начать игру",
            estimatedTime: 10,
            gameFlow: .initial
        ),
        reducer: Self()
    )
    
    static let previewStorePlayState = GameStore(
        initialState: Self.State(
            title: "Some question",
            gameFlow: .play
        ),
        reducer: Self()
    )
    
    static let previewStorePauseState = GameStore(
        initialState: Self.State(
            title: "Pause",
            gameFlow: .pause
        ),
        reducer: Self()
    )
    
    static let previewStoreGameOverState = GameStore(
        initialState: Self.State(
            title: "Конец игры",
            quest: "В следующем раунде, после каждого ответа, хлопать в ладоши",
            gameFlow: .gameOver,
            isShowSheet: true
        ),
        reducer: Self()
    )
}

private extension GameDomain {
    func getRandomElement(from collection: [String]) -> String {
        let randomIndex = randomNumber(collection.count)
        return collection[randomIndex]
    }
    
    func togglePause(_ gameFlow: State.GameFlow) -> Action? {
        switch gameFlow {
        case .play:
            return .setGameState(.pause)
        case .pause:
            return .setGameState(.play)
        default:
            return nil
        }
    }
}

extension GameDomain.State {
    enum GameFlow: Codable {
        case initial
        case play
        case pause
        case gameOver
        
        init() {
            self = .initial
        }
    }
}
