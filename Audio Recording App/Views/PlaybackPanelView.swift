//
//  PlaybackPanelView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import SwiftUI

struct PlaybackPanelView: View {
    @ObservedObject private(set) var viewModel: PlaybackPanelViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(viewModel.item.name)
                        .font(.title2).bold()
                    Text(viewModel.item.date)
                        .font(.footnote).foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 12) {
                    if let url = viewModel.item.url {
                        if #available(macOS 13.0, *) {
                            ShareLink(item: url) { Label("Share", systemImage: "square.and.arrow.up") }
                        } else {
                            
                        }
                    }
                }
            }
            
            VStack {
                Slider(value: Binding(get: { viewModel.playbackPosition }, set: { viewModel.playbackPosition = $0 }), in: 0...Double(max(1, viewModel.item.durationInSeconds)))
                HStack {
                    Text(viewModel.playbackPosition.asTime).font(.caption)
                    Spacer()
                    Text(viewModel.item.duration).font(.caption).foregroundStyle(.secondary)
                }
            }

            HStack(spacing: 20) {
                Button(action: viewModel.togglePlayPause, label: {
                    Image(systemName: viewModel.playbackState.isPlaying ? "pause.fill" : "play.fill").font(.title2)
                })
                .buttonStyle(.bordered)

                Button(
                    action: viewModel.stopPlayback,
                    label: {
                        Image(systemName: "stop.fill").font(.title2)
                    }
                )
                Spacer()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding(28)
    }
    
    
}

private extension Double {
    var asTime: String {
        formatTime(Int(self))
    }
    
    private func formatTime(_ secs: Int) -> String {
        String(format: "%02d:%02d", secs/60, secs%60)
    }
}
