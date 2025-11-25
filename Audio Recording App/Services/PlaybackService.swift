//
//  PlaybackService.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation
import AVFoundation

final class PlaybackService: NSObject, ObservableObject {
    @Published private var player: AVAudioPlayer? {
        didSet {
            if let player {
                player.prepareToPlay()
                player.delegate = self
                state.currentTime = player.currentTime
            } else {
                state.stop()
                stopTimer()
            }
        }
    }
    
    private var timer: Timer?
    
    let state: PlaybackState
    
    init(state: PlaybackState = PlaybackState()) {
        self.state = state
        super.init()
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            self.state.currentTime = player.currentTime
            
            if !player.isPlaying {
                self.stopTimer()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension PlaybackService: PlaybackManagerProtocol {
    func load(url: URL) throws {
        stop()
        player = try AVAudioPlayer(contentsOf: url)
    }

    func play(item: LocalRecordingItem) throws {
        guard let url = item.fileURL else { return }
        try load(url: url)
        player?.play()
        try? state.play(item: item)
        startTimer()
    }

    func pause() {
        player?.pause()
        state.pause()
        
        stopTimer()
    }

    func stop() {
        player?.stop()
        player?.currentTime = 0
        player = nil
    }

    func seek(to time: TimeInterval) {
        player?.currentTime = time
        state.currentTime = time
    }
}

extension PlaybackService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        state.stop()
        stopTimer()
    }
}
