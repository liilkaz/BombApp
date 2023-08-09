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
    func playTicking()
    func playBlow()
    func stop()
}

final class AudioPlayer: AudioPlayerProtocol {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AudioPlayer.self)
    )
    //MARK: - Players
    private var bombTickPlayer: AVAudioPlayer?
    private var explosionPlayer: AVAudioPlayer?
    
    //MARK: - init/deinit
    init() {
        let bundle = Bundle.main
        guard
            let bombTickUrl = bundle.url(forResource: "bombTick", withExtension: "mp3"),
            let explosionUrl = bundle.url(forResource: "Explosion", withExtension: "mp3")
        else {
            logger.fault("Unable to find some of mp3 files in bundle")
            return
        }
        
        do {
            bombTickPlayer = try AVAudioPlayer(contentsOf: bombTickUrl)
            explosionPlayer = try AVAudioPlayer(contentsOf: explosionUrl)
        } catch {
            logger.error("Unable to initialize player: \(error.localizedDescription)")
        }
        
        bombTickPlayer?.prepareToPlay()
        logger.debug("Initialized")
    }
    
    deinit {
        logger.debug("Deinitialised")
    }
    
    //MARK: - Public methods
    func playTicking() {
        bombTickPlayer?.currentTime = 0
        bombTickPlayer?.play()
        logger.debug("Start play timer")
    }
    
    func playBlow() {
        stop()
        explosionPlayer?.currentTime = 0
        explosionPlayer?.play()
        logger.debug("Start play explosion")
    }
    
    func stop() {
        bombTickPlayer?.stop()
        logger.debug("Stop player.")
    }
}
