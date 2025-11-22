//
//  SidebarView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct SidebarView: View {
    let viewModel: Recordable
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Recordings").font(.title3).bold()
                Spacer()
                Button {
                    viewModel.startNewRecording()
                } label: {
                    Image(systemName: "record.circle.fill")
                        .font(.title2)
                }
                .buttonStyle(BorderlessButtonStyle())
                .help("Start new recording")
            }
            .padding([.top, .horizontal], 12)
        }
    }
}
