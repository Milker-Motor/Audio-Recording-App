//
//  RecordingPanel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import SwiftUI

final class RecordingPanelViewModel: ObservableObject {
    @Published private(set) var timer: String = "00:00"
}

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
        }
        .padding(28)
    }
}
