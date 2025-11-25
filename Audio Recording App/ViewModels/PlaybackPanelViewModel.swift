//
//  PlaybackPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation
import Combine

final class PlaybackPanelViewModel: ObservableObject {
    private let playback: PlaybackManagerProtocol
    let item: RecordingRowItem
    @Published var playbackState: PlaybackState
    
    @Published var playbackPosition: TimeInterval
    private var cancellable = Set<AnyCancellable>()
    
    init(item: RecordingRowItem, playback: PlaybackManagerProtocol) {
        self.item = item
        self.playback = playback
        self.playbackPosition = 0
        self.playbackState = playback.state
        
        playbackState.$currentTime
            .assign(to: \.playbackPosition, on: self)
            .store(in: &cancellable)
        
        //playback.$currentTime
        
    }
    
    func togglePlayPause() {
        if playbackState.isPlaying {
            playback.pause()
        } else {
            try? playback.play(item: LocalRecordingItem(fileURL: item.url, duration: item.durationInSeconds, format: .m4a))
        }
    }
    
    func stopPlayback() {
        playback.stop()
    }
}
