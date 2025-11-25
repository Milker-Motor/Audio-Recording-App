//
//  PlaybackState.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation

final class PlaybackState: ObservableObject {
    @Published private(set) var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0
}

extension PlaybackState: PlaybackManagerProtocol {
    var state: PlaybackState { self }
    
    func load(url: URL) throws { }
    func play(item: LocalRecordingItem) throws { isPlaying = true }
    func pause() { isPlaying = false }
    func stop() {
        isPlaying = false
        currentTime = 0
    }
    func seek(to time: TimeInterval) {}
}
