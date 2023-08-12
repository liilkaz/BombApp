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
    private enum Catalog: String {
        case timer
        case explosion
        case background
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
        
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) else {
            logger.fault("Unable to locate mp3 files.")
            return
        }
        
        tickPlayers = urls
            .filter { $0.pathComponents.last!.contains(Catalog.timer.rawValue) }
            .reduce(into: [AVAudioPlayer](), tryMapToPlayer)
        
        explosionPlayers = urls
            .filter { $0.pathComponents.last!.contains(Catalog.explosion.rawValue) }
            .reduce(into: [AVAudioPlayer](), tryMapToPlayer)
        
        backgroundPlayers = urls
            .filter { $0.pathComponents.last!.contains(Catalog.background.rawValue) }
            .reduce(into: [AVAudioPlayer](), tryMapToPlayer)
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
        explosionPlayer = explosionPlayers[melody.rawValue]
        explosionPlayer?.currentTime = 0
        explosionPlayer?.play()
        logger.debug("Start play explosion")
    }
    
    func playBackgroundMusic(_ melody: Settings.Melody) {
        guard melody.rawValue < backgroundPlayers.count else {
            logger.fault("Index of player out of range")
            return
        }
        backgroundPlayer = backgroundPlayers[melody.rawValue]
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
    func tryMapToPlayer(_ result: inout [AVAudioPlayer], _ url: URL) {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            result.append(player)
        } catch {
            logger.fault("Unable to load content of \(url)\n Reason: \(error.localizedDescription)")
        }
    }
}
