//
//  AppContentView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct AppContentView: View {
    @ObservedObject private var viewModel: RecordingViewModel
    
    init(recordable: Recordable, dataStore: RecordingDataStore, recordingState: RecordingState) {
        self.viewModel = RecordingViewModel(recordable: recordable, dataStore: dataStore, state: recordingState)
    }
    
    var body: some View {
        let detailContainerViewModel = DetailContainerViewModel(recordable: viewModel.recordable, dataStore: viewModel.dataStore, state: viewModel.state, detailMode: .none)
        let detailContainerView = DetailContainerView(viewModel: detailContainerViewModel)
        
        let sidebarViewModel = SidebarViewModel(dataStore: viewModel.dataStore) {
            detailContainerViewModel.detailMode = .recording
        } onSelect: { item in
            detailContainerViewModel.detailMode = .playback(item)
        }

        let sidebarView = SidebarView(viewModel: sidebarViewModel)
        
        if #available(macOS 13.0, *) {
            NavigationSplitView {
                sidebarView
            } detail: {
                detailContainerView         }
        } else {
            NavigationView {
                sidebarView
                detailContainerView
            }
            .frame(minWidth: 800, minHeight: 600)
        }
    }
}
