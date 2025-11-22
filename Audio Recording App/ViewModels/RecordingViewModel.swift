//
//  RecordingViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class RecordingViewModel: ObservableObject {
    let recordable: Recordable
    
    init(recordable: Recordable) {
        self.recordable = recordable
    }
}
