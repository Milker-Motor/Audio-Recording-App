//
//  AppContentView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct AppContentView: View {
    @ObservedObject private var viewModel: AppContentViewModel
    
    init(recordable: Recordable, dataStore: RecordingDataStore) {
        self.viewModel = AppContentViewModel(recordable: recordable, dataStore: dataStore)
    }
    
    var body: some View {
        let detailContainerView = DetailContainerView(viewModel: viewModel.detailContainerViewModel)
        
        let sidebarView = SidebarView(viewModel: viewModel.sidebarViewModel)
        
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
