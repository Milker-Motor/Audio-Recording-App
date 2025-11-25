//
//  WaveformViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation
import Combine

final class WaveformViewModel: ObservableObject {
    private let recorder: Recordable
    private var cancellable = Set<AnyCancellable>()
    
    @Published private(set) var levels: [CGFloat] = Array(repeating: 0.02, count: 20)
    private var timer: Timer?
    init(recorder: Recordable) {
        self.recorder = recorder
        
        recorder.state.$state
            .sink { [weak self] state in
                if state == .recording {
                    self?.startMeters()
                } else {
                    self?.stopMeters()
                }
            }
            .store(in: &cancellable)
            
    }
    
    private func startMeters() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            DispatchQueue.main.async { [weak self] in
//                Task { @MainActor in
                    self?.updateLevel()
//                }
            }
        }
    }
    
    @MainActor
    private func updateLevel() {
        guard recorder.isRecording else { return }

        recorder.updateMeters()
        let avg = recorder.averagePower(forChannel: 0)
        let norm = normalizedPower(fromDecibels: avg)

        levels.removeFirst()
        levels.append(CGFloat(norm))
    }
    
    private func stopMeters() {
        timer?.invalidate()
        timer = nil
        levels = Array(repeating: 0.02, count: levels.count)
    }
    
    private func normalizedPower(fromDecibels db: Float) -> Float {
        let minDb: Float = -100
        if db < minDb { return 0 }
        let level = pow(10.0, db / 20.0)
        return max(0.0, min(1.0, level))
    }
}

//extension WaveformViewModel: Recordable {
//    var isRecording: Bool {
//        recorder.isRecording
//    }
//    
//    func startNewRecording() async throws {
//        startMeters()
//        try await recorder.startNewRecording()
//    }
//    
//    func stopRecording() throws -> URL? {
//        stopMeters()
//        return try recorder.stopRecording()
//        
//    }
//    
//    func pauseRecording() {
//        stopMeters()
//        recorder.pauseRecording()
//    }
//    
//    func resumeRecording() {
//        recorder.resumeRecording()
//        if recorder.isRecording {
//            startMeters()
//        } else {
//            stopMeters()
//        }
//    }
//    
//    func updateMeters() {
//        recorder.updateMeters()
//    }
//    
//    func averagePower(forChannel channelNumber: Int) -> Float {
//        recorder.averagePower(forChannel: channelNumber)
//    }
//}
