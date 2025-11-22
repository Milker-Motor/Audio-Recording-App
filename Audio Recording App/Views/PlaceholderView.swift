//
//  PlaceholderView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct PlaceholderView: View {
    let viewModel: Recordable
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {
                viewModel.startNewRecording()
            }) {
                Image(systemName: "mic.circle")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(PlainButtonStyle())
            Text("Select a recording or start a new one")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
