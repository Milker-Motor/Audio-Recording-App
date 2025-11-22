//
//  DetailContainerView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

struct DetailContainerView: View {
    let viewModel: Recordable
    var body: some View {
        Group {
            PlaceholderView(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
