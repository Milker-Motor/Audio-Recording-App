//
//  RecordingPanel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import SwiftUI

struct RecordingPanelView: View {
    @ObservedObject var viewModel: RecordingPanelViewModel
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
            HStack(spacing: 28) {
                Button {
                    print(viewModel.isPaused ? "Resume" : "Pause")
                } label: {
                    Label(viewModel.isPaused ? "Resume" : "Pause", systemImage: viewModel.isPaused ? "play.fill" : "pause.fill")
                        .font(.title3)
                }
                .keyboardShortcut(.space, modifiers: [])

                Button {
                    
                    print("Stop")
                } label: {
                    Label("Stop", systemImage: "stop.fill").font(.title3)
                }
                .keyboardShortcut(.init("s"), modifiers: [])

                Spacer()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            Spacer()
        }
        .padding(28)
    }
}
