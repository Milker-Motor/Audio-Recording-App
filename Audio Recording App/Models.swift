//
//  Models.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

enum AppError: LocalizedError, Identifiable {
    case recordingFailed(String)
    case permissionDenied
    case unknown(String)

    var id: String { localizedDescription }

    var errorDescription: String? {
        switch self {
        case .recordingFailed(let message):
            return "Recording Failed: \(message)"
            
        case .permissionDenied:
            
            return "Microphone access is denied."
            
        case .unknown(let message):
            return message
        }
    }
}
