//
//  RecordingRow.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import SwiftUI

struct RecordingRowItem: Hashable, Identifiable {
    let id: UUID = UUID()
    
    let name: String
    let durationInSeconds: Int
    let date: String
    let url: URL?
    
    var duration: String {
        String(format: "%02d:%02d", durationInSeconds / 60, durationInSeconds % 60)
    }
    var fileExist: Bool { url != nil }
}

struct RecordingRow: View {
    let item: RecordingRowItem
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name).font(.body)
                HStack(spacing: 12) {
                    Text(item.duration)
                    Text(item.date)
                }
                .font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
