//
//  Audio_Recording_AppApp.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 21.11.2025.
//

import SwiftUI

@main
struct Audio_Recording_AppApp: App {
    let state = RecordingState(format: .m4a, sampleRate: 44_100, url: { format in
        let tmp = FileManager.default.temporaryDirectory
        let filename = "Recording_\(Int(Date().timeIntervalSince1970)).\(format)"
        let url = tmp.appendingPathComponent(filename)
        return url
    })
    
    
    var body: some Scene {
        let recordingManager = RecordingManager(audioRecorder: AudioRecorder(), state: state)
        WindowGroup {
            AppContentView(recordable: recordingManager, recordingState: state)
        }
    }
}
