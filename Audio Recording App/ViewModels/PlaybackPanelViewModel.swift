//
//  PlaybackPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation

final class PlaybackPanelViewModel: ObservableObject {
    let item: RecordingRowItem
    private(set) var isPlaying = false
    
    @Published var playbackPosition: Double
    
    init(item: RecordingRowItem) {
        self.item = item
        self.playbackPosition = 0
    }
    
}
