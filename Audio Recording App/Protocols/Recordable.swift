//
//  Recordable.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import Foundation

protocol Recordable {
    var state: RecordingState { get }
    var isRecording: Bool { get }
    
    func startNewRecording() async throws
    func stopRecording() throws -> URL?
    func pauseRecording()
    func resumeRecording()
    
    func updateMeters()
    func averagePower(forChannel channelNumber: Int) -> Float
}
