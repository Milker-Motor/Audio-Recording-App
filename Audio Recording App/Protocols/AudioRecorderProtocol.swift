//
//  AudioRecorderProtocol.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation

protocol AudioRecorderProtocol {
    var isRecording: Bool { get }
    var state: AudioRecorderState { get }
    
    func startRecording(to url: URL, format: AudioFormat, sampleRate: Double) async throws
    func pauseRecording()
    func resumeRecording()
    func stopRecording() -> URL?
    func updateMeters()
    func averagePower(forChannel channelNumber: Int) -> Float
}
