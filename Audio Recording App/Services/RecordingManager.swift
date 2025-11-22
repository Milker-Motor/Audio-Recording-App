//
//  RecordingManager.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class RecordingManager: ObservableObject {
    @ObservedObject private(set) var state: RecordingState
    init(state: RecordingState) {
        self.state = state
    }
}

extension RecordingManager: Recordable {
    func startNewRecording() {
        state.mode = .recording
    }
}
