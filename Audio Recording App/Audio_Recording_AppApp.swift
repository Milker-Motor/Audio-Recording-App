//
//  Audio_Recording_AppApp.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 21.11.2025.
//

import SwiftUI

@main
struct Audio_Recording_AppApp: App {
    let state = RecordingState(format: .m4a, sampleRate: 48_000, url: { format in
        let tmp = FileManager.default.temporaryDirectory
        let filename = "Recording_\(Int(Date().timeIntervalSince1970)).\(format)"
        let url = tmp.appendingPathComponent(filename)
        return url
    })
        
    var body: some Scene {
        let store = try! CoreDataRecordingStore(
            storeURL: NSPersistentContainer
                .defaultDirectoryURL()
                .appendingPathComponent("Recordings-store.sqlite")
        )
        let localFeedLoader = LocalRecordingDataLoader(store: store)
        let recordingManager = RecordingManager(audioRecorder: AudioRecorder(), dataStore: localFeedLoader, state: state)
        WindowGroup {
            AppContentView(recordable: recordingManager, dataStore: store, recordingState: state)
        }
    }
}
