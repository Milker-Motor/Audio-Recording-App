//
//  AppContentView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct AppContentView: View {
    @ObservedObject private var viewModel: RecordingViewModel
    
    init(recordable: Recordable, recordingState: RecordingState) {
        self.viewModel = RecordingViewModel(recordable: recordable, state: recordingState)
    }
    
    var body: some View {
        if #available(macOS 13.0, *) {
            NavigationSplitView {
                SidebarView(viewModel: viewModel.recordable)
            } detail: {
                DetailContainerView(viewModel: DetailContainerViewModel(recordable: viewModel.recordable, state: viewModel.state))
            }
        } else {
            NavigationView {
                SidebarView(viewModel: viewModel.recordable)
                DetailContainerView(viewModel: DetailContainerViewModel(recordable: viewModel.recordable, state: viewModel.state))
            }
            .frame(minWidth: 800, minHeight: 600)
        }
    }
}
