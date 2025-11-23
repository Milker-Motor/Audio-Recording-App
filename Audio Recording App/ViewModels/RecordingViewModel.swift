//
//  RecordingViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class RecordingViewModel: ObservableObject {
    let recordable: Recordable
    let state: RecordingState
    
    @Published var uiError: AppError?
    
    init(recordable: Recordable, state: RecordingState) {
        self.recordable = recordable
        self.state = state
    }
}
