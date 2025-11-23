//
//  DetailContainerView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

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
                PlaceholderView(viewModel: PlaceholderViewModel(recordable: viewModel.recordable))
            case .recording:
                RecordingPanelView(viewModel: RecordingPanelViewModel(recordableState: viewModel.recordingStatable))
            case .playback:
                Text("Replace me")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
