//
//  AudioPlayer.swift
//  Bomb
//
//  Created by Илья Шаповалов on 08.08.2023.
//

import Foundation
import AVFoundation
import OSLog

protocol AudioPlayerProtocol: AnyObject {
    func playTicking(_ melody: Settings.Melody)
    func playExplosion(_ melody: Settings.Melody)
    func playBackgroundMusic(_ melody: Settings.Melody)
    func stop()
}

final class AudioPlayer: AudioPlayerProtocol {
    private struct Catalog {
        static let timers = "Timer"
        static let explosions = "Explosion"
        static let background = "Background"
    }
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AudioPlayer.self)
    )
    //MARK: - Players
    private var bombTickPlayer: AVAudioPlayer?
    private var explosionPlayer: AVAudioPlayer?
    private var backgroundPlayer: AVAudioPlayer?
    
    private var tickPlayers: [AVAudioPlayer] = .init()
    private var explosionPlayers: [AVAudioPlayer] = .init()
    private var backgroundPlayers: [AVAudioPlayer] = .init()
    
    //MARK: - init/deinit
    init() {
        logger.debug("Initialized")
        
        loadContent(of: Catalog.timers, to: &tickPlayers)
        loadContent(of: Catalog.explosions, to: &explosionPlayers)
        loadContent(of: Catalog.background, to: &backgroundPlayers)
    }
    
    deinit {
        logger.debug("Deinitialised")
    }
    
    //MARK: - Public methods
    func playTicking(_ melody: Settings.Melody) {
        guard melody.rawValue < tickPlayers.count else {
            logger.fault("Index of player out of range")
            return
        }
        bombTickPlayer = tickPlayers[melody.rawValue]
        bombTickPlayer?.currentTime = 0
        bombTickPlayer?.play()
        logger.debug("Start play timer")
    }
    
    func playExplosion(_ melody: Settings.Melody) {
        stop()
        guard melody.rawValue < explosionPlayers.count else {
            logger.fault("Index of player out of range")
            return
        }
        explosionPlayer?.currentTime = 0
        explosionPlayer?.play()
        logger.debug("Start play explosion")
    }
    
    func playBackgroundMusic(_ melody: Settings.Melody) {
        guard melody.rawValue < backgroundPlayers.count else {
            logger.fault("Index of player out of range")
            return
        }
        backgroundPlayer?.currentTime = 0
        backgroundPlayer?.play()
        logger.debug("Start play background melody")
    }
    
    func stop() {
        bombTickPlayer?.stop()
        backgroundPlayer?.stop()
        logger.debug("Stop player.")
    }
}

private extension AudioPlayer {
    func loadContent(of subdirectory: String, to players: inout [AVAudioPlayer]) {
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "Timer") else {
            logger.fault("Unable to locate subdirectory \(subdirectory)")
            return
        }
        players = urls.reduce(into: [AVAudioPlayer](), tryMapToPlayer)
    }
    
    func tryMapToPlayer(_ result: inout [AVAudioPlayer], _ url: URL) {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            result.append(player)
        } catch {
            logger.fault("Unable to load content of \(url)\n Reason: \(error.localizedDescription)")
        }
    }
}
