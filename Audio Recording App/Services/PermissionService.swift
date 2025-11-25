//
//  PermissionService.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import Foundation
import AVFoundation

enum MicrophonePermission {
    case authorized, denied, notDetermined, restricted
}

final class PermissionService {
    private init() {}
    
    static var authorizationStatus: MicrophonePermission {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized: return .authorized
        case .denied: return .denied
        case .restricted: return .restricted
        case .notDetermined: return .notDetermined
        @unknown default: return .notDetermined
        }
    }
    
    static func requestPermission() async throws -> MicrophonePermission {
        try await withCheckedThrowingContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                if granted {
                    continuation.resume(returning: .authorized)
                } else {
                    continuation.resume(throwing: AppError.permissionDenied)
                }
            }
        }
    }
}
