//
//  Recordable.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import Foundation

protocol Recordable {
    func startNewRecording()
}

class RecordingState: ObservableObject {
    @Published var mode: DetailMode = .none
    @Published var isPaused: Bool = false
}

public enum DetailMode: Equatable {
    case none
    case recording
    case playback
}
