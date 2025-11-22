//
//  AppContentView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct AppContentView: View {
    var body: some View {
        if #available(macOS 13.0, *) {
            NavigationSplitView {
                SidebarView(viewModel: viewModel.recordable)
            } detail: {
                DetailContainerView(viewModel: viewModel.recordable)
            }
        } else {
            NavigationView {
                SidebarView(viewModel: viewModel.recordable)
                DetailContainerView(viewModel: viewModel.recordable)
            }
            .frame(minWidth: 800, minHeight: 600)
        }
    }
    
    @StateObject private var viewModel = RecordingViewModel(
        recordable: RecordingManager()
    )
}
