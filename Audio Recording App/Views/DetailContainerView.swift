//
//  DetailContainerView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

enum DetailMode: Equatable {
    case none
    case recording
    case playback(RecordingRowItem)
}

struct DetailContainerView: View {
    @ObservedObject private(set) var viewModel: DetailContainerViewModel
    @ObservedObject var recordingState: RecordingState
    init(viewModel: DetailContainerViewModel) {
        self.viewModel = viewModel
        self.recordingState = viewModel.recordingStatable
    }
    
    var body: some View {
        Group {
            switch viewModel.detailMode {
            case .none:
                let placeholderViewModel = PlaceholderViewModel {
                    self.viewModel.detailMode = .recording
                }
                PlaceholderView(viewModel: placeholderViewModel)
            case .recording:
                RecordingPanelView(viewModel: RecordingPanelViewModel(recordable: viewModel.recordable, dataStore: viewModel.dataStore, recordableState: viewModel.recordingStatable))
            case let .playback(item):
                PlaybackPanelView(viewModel: PlaybackPanelViewModel(item: item))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .id(viewModel.detailMode)
    }
}
