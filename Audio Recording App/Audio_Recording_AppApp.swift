//
//  Audio_Recording_AppApp.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 21.11.2025.
//

import SwiftUI

@main
struct Audio_Recording_AppApp: App {
    let state = RecordingState()
    
    
    var body: some Scene {
        let recordingManager = RecordingManager(state: state)
        WindowGroup {
            AppContentView(recordable: recordingManager, recordingState: state)
        }
    }
}
