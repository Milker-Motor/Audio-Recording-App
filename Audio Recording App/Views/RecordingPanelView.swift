//
//  RecordingPanel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import SwiftUI

struct RecordingPanelView: View {
    @StateObject var viewModel: RecordingPanelViewModel
    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("Recording…").font(.title2).bold()
                Spacer()
                HStack(spacing: 6) {
                    Circle().foregroundStyle(.red).frame(width: 10, height: 10)
                    Text("LIVE").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                }
            }
            Text(viewModel.timer)
                .font(.system(size: 48, weight: .semibold, design: .monospaced))
                .monospacedDigit()
            WaveformView(viewModel: WaveformViewModel(recorder: viewModel.recordable))
                .frame(height: 120)
                .padding(.horizontal, 8)
            HStack(spacing: 28) {
                Button {
                    viewModel.togglePauseResumeRecording()
                } label: {
                    Label(viewModel.isPaused ? "Resume" : "Pause", systemImage: viewModel.isPaused ? "play.fill" : "pause.fill")
                        .font(.title3)
                }
                .disabled(viewModel.uiError == .permissionDenied)
                .keyboardShortcut(.space, modifiers: [])
                
                Button {
                    _ = try? viewModel.stopRecording()
                } label: {
                    Label("Stop", systemImage: "stop.fill").font(.title3)
                }
                .disabled(viewModel.uiError == .permissionDenied)
                .keyboardShortcut(.init("s"), modifiers: [])
                
                Spacer()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            Spacer()
        }
        .padding(28)
        .alert(item: $viewModel.uiError) { error in
            switch error {
            case .permissionDenied:
                return Alert(
                    title: Text("Microphone Permission Denied"),
                    message: Text("Please enable microphone access in System Settings → Privacy & Security → Microphone."),
                    primaryButton: .default(Text("Open Settings")) { openAppSettings() },
                    secondaryButton: .cancel()
                )
            default:
                return Alert(
                    title: Text("Error"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            Task {
                try? await viewModel.startNewRecording()
            }
            
        }
    }
    
    private func openAppSettings() {
        if let url = URL(string: "x-apple.systempreferences:com.apple.settings.Privacy") {
            NSWorkspace.shared.open(url)
        }
    }
}
