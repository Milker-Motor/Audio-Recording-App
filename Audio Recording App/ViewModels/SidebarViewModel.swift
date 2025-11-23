//
//  SidebarViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class SidebarViewModel: ObservableObject {
    @Published var uiError: AppError?
    
    func startNewRecording() {
        do {
            try recordable.startNewRecording()
        } catch {
            Task { @MainActor in
                self.uiError = .recordingFailed(error.localizedDescription)
            }
        }
    }
    
    private let recordable: Recordable
    init(recordable: Recordable) {
        self.recordable = recordable
    }
}
