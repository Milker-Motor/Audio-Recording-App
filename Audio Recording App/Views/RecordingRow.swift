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
    let duration: String
    let date: String
    let fileExist: Bool
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
            Image(systemName: "square.and.arrow.up").foregroundStyle(.secondary).opacity(item.fileExist ? 1.0 : 0.25)
        }
        .padding(.vertical, 8)
    }
}
