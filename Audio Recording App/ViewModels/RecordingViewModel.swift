//
//  RecordingViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class RecordingViewModel: ObservableObject {
    let recordable: Recordable
    let dataStore: RecordingDataStore
    
    @Published var uiError: AppError?
    
    init(recordable: Recordable, dataStore: RecordingDataStore) {
        self.recordable = recordable
        self.dataStore = dataStore
    }
}
