//
//  PlaybackPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation
import SwiftUI
import Combine

final class PlaybackPanelViewModel: ObservableObject {
    @Published var isPlaying: Bool
    @Published var playbackPosition: TimeInterval
    
    let item: RecordingRowItem
    
    private let playback: PlaybackManagerProtocol
    let recorder: Recordable
    private var cancellable = Set<AnyCancellable>()
    
    init(item: RecordingRowItem, playback: PlaybackManagerProtocol, recorder: Recordable) {
        self.item = item
        self.playback = playback
        self.recorder = recorder
        self.isPlaying = playback.state.isPlaying
        self.playbackPosition = playback.state.currentTime
        
        playback.state.$currentTime
            .receive(on: RunLoop.main)
            .assign(to: \.playbackPosition, on: self)
            .store(in: &cancellable)
        
        playback.state.$isPlaying
            .receive(on: RunLoop.main)
            .assign(to: \.isPlaying, on: self)
            .store(in: &cancellable)
        
    }
    
    var playbackState: PlaybackState { playback.state }
    
    func togglePlayPause() {
        if playback.state.isPlaying {
            playback.pause()
        } else {
            try? playback.play(item: LocalRecordingItem(fileURL: item.url, duration: item.durationInSeconds, format: .m4a))
        }
    }
    
    func stopPlayback() {
        playback.stop()
    }
}
