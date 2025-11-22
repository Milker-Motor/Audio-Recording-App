//
//  DetailContainerView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class DetailContainerViewModel: ObservableObject {
    private(set) var recordable: Recordable
    private(set) var recordingStatable: RecordingState
    
    init(recordable: Recordable, state: RecordingState) {
        self.recordable = recordable
        self.recordingStatable = state
    }
}

struct DetailContainerView: View {
    let viewModel: DetailContainerViewModel
    @ObservedObject var recordingState: RecordingState
    init(viewModel: DetailContainerViewModel) {
            self.viewModel = viewModel
            self.recordingState = viewModel.recordingStatable
        }
    
    var body: some View {
        Group {
            switch viewModel.recordingStatable.mode {
            case .none:
                PlaceholderView(viewModel: viewModel.recordable)
            case .recording:
                RecordingPanel()
            case .playback:
                Text("Replace me")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
