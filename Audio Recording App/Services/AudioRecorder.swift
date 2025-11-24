//
//  AudioRecorder.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation
import AVFoundation

enum AudioRecorderState {
    case stopped, recording, paused
}

enum AudioFormat: String, Codable {
    case m4a, wav, caf
}

protocol AudioRecorderProtocol {
    var state: AudioRecorderState { get }
    
    func startRecording(to url: URL, format: AudioFormat, sampleRate: Double) throws
    func pauseRecording()
    func resumeRecording()
    func stopRecording() -> URL?
}

final class AudioRecorder: AudioRecorderProtocol {
    private(set) var state: AudioRecorderState = .stopped
    private var recorder: AVAudioRecorder?
    
    func startRecording(to url: URL, format: AudioFormat, sampleRate: Double) throws {
        stopRecordingIfNeeded()
        
        let settings = settings(for: format, sampleRate: sampleRate)
        recorder = try AVAudioRecorder(url: url, settings: settings)
        recorder?.isMeteringEnabled = true
        recorder?.prepareToRecord()
        
        guard isRecordSuccessful else { throw NSError(domain: "RecordingManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to start recorder"]) }
        
        state = .recording
    }
    
    func pauseRecording() {
        guard state == .recording else { return }
        recorder?.pause()
        state = .paused
    }
    
    func resumeRecording() {
        guard state == .paused else { return }
        
        if isRecordSuccessful {
            state = .recording
        } else {
            stopRecording()
        }
    }
    
    func stopRecording() -> URL? {
        guard state != .stopped else { return nil }
        recorder?.stop()
        state = .stopped
        return recorder?.url
    }
    
    private var isRecordSuccessful: Bool {
        recorder?.record() ?? false
    }
    
    private func stopRecordingIfNeeded() {
        guard state != .stopped else { return }
        
        recorder?.stop()
        state = .stopped
    }
    
    private func settings(for format: AudioFormat, sampleRate: Double) -> [String: Any] {
        switch format {
        case .m4a:
            return [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: sampleRate,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
        case .wav:
            return [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: sampleRate,
                AVNumberOfChannelsKey: 1,
                AVLinearPCMBitDepthKey: 16,
                AVLinearPCMIsBigEndianKey: false,
                AVLinearPCMIsFloatKey: false
            ]
        case .caf:
            return [
                AVFormatIDKey: Int(kAudioFormatAppleIMA4),
                AVSampleRateKey: sampleRate,
                AVNumberOfChannelsKey: 1
            ]
        }
    }
}
