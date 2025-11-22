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
                SidebarView()
            } detail: {
                DetailContainerView()
            }
        } else {
            NavigationView {
                SidebarView()
                DetailContainerView()
            }
            .frame(minWidth: 800, minHeight: 600)
        }
    }
}

#Preview {
    AppContentView()
}
