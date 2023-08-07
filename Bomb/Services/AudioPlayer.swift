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
    func play()
    func stop()
}

final class AudioPlayer: AudioPlayerProtocol {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: AudioPlayer.self)
    )
    
    private var player: AVAudioPlayer?
    
    //MARK: - init/deinit
    init() {
        guard let url = Bundle.main.url(forResource: "bombTick", withExtension: "mp3") else {
            logger.fault("Unable to find bombTick.mp3 in bundle")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            logger.error("Unable to initialize AVAudioPlayer: \(error.localizedDescription)")
        }
        
        logger.debug("Initialized")
    }
    
    deinit {
        logger.debug("Deinitialised")
    }
    
    //MARK: - Public methods
    func play() {
        player?.play()
        logger.debug("Start play")
    }
    
    func stop() {
        player?.stop()
        logger.debug("Stop play")
    }
}
