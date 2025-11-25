//
//  AudioRecorder.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation
import AVFoundation
import AppKit

enum AudioRecorderState {
    case stopped, recording, paused
}

enum AudioFormat: String, Codable {
    case m4a, wav, caf
}

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

final class AudioRecorder: AudioRecorderProtocol {
    private(set) var state: AudioRecorderState = .stopped {
        didSet {
            updateDockBadge(state == .recording)
        }
    }
    private var recorder: AVAudioRecorder?
    
    var isRecording: Bool { recorder?.isRecording ?? false }
    
    func updateMeters() {
        recorder?.updateMeters()
    }
    
    func startRecording(to url: URL, format: AudioFormat, sampleRate: Double) async throws {
        try await handlePermissions()
        stopRecordingIfNeeded()
        
        let settings = settings(for: format, sampleRate: sampleRate)
        recorder = try AVAudioRecorder(url: url, settings: settings)
        recorder?.isMeteringEnabled = true
        recorder?.prepareToRecord()
        
        guard isRecordSuccessful else { throw AppError.recordingFailed("Failed to start recorder") }
        
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
    
    @discardableResult
    func stopRecording() -> URL? {
        guard state != .stopped else { return nil }
        recorder?.stop()
        state = .stopped
        return recorder?.url
    }
    
    func averagePower(forChannel channelNumber: Int) -> Float {
        recorder?.averagePower(forChannel: channelNumber) ?? 0
    }
    
    private var isRecordSuccessful: Bool {
        recorder?.record() ?? false
    }
    
    private func handlePermissions() async throws {
        switch PermissionService.authorizationStatus {
        case .authorized:
            return
        case .notDetermined:
            let newStatus = try await PermissionService.requestPermission()
            if newStatus != .authorized {
                throw AppError.permissionDenied
            }
        default:
            throw AppError.permissionDenied
        }
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
    
    private func updateDockBadge(_ recording: Bool) {
        DispatchQueue.main.async {
            if recording {
                NSApp.dockTile.badgeLabel = "●"
            } else {
                NSApp.dockTile.badgeLabel = nil
            }
        }
    }
}
