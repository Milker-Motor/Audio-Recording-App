//
//  PlaybackManager.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation
import AVFoundation
import Combine

final class PlaybackState: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
}

protocol PlaybackManagerProtocol {
    var state: PlaybackState { get }
//    var isPlaying: Bool { get }
//    var currentTime: TimeInterval { get }
    func load(url: URL) throws
    func play(item: LocalRecordingItem) throws
    func pause()
    func stop()
    func seek(to time: TimeInterval)
}

final class PlaybackManager: NSObject, ObservableObject {
    private var player: AVAudioPlayer? {
        didSet {
            player?.prepareToPlay()
            player?.delegate = self
        }
    }
    
    let state: PlaybackState
    init(state: PlaybackState = PlaybackState()) {
        self.state = state
        super.init()
    }
    private var timer: Timer?
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            self.state.currentTime = player.currentTime
            if !player.isPlaying {
                self.state.isPlaying = false
                self.stopTimer()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension PlaybackManager: PlaybackManagerProtocol {
    
//    var isPlaying: Bool {
//        state.isPlaying
//    }
//    
//    var currentTime: TimeInterval {
//        state.currentTime
//    }
    
    func load(url: URL) throws {
        stop()
        player = try AVAudioPlayer(contentsOf: url)
        
        state.currentTime = player?.currentTime ?? 0
    }

    func play(item: LocalRecordingItem) throws {
        guard let url = item.fileURL else { return }
        try load(url: url)
        player?.play()
        state.isPlaying = true
        startTimer()
    }

    func pause() {
        player?.pause()
        state.isPlaying = false
        stopTimer()
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        state.isPlaying = false
        state.currentTime = 0
        stopTimer()
        player = nil
    }

    func seek(to time: TimeInterval) {
        player?.currentTime = time
        state.currentTime = time
    }
}

extension PlaybackManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        state.isPlaying = false
        stopTimer()
    }
}

