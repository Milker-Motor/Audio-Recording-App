//
//  WaveformView.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import SwiftUI

struct WaveformView: View {
    @ObservedObject var viewModel: WaveformViewModel

    var body: some View {
        GeometryReader { geo in
            let maxH = geo.size.height
            HStack(alignment: .center, spacing: 4) {
                ForEach(viewModel.levels, id: \.self) { level in
                    let height = max(3, maxH * (0.05 + 0.95 * level))
                    
                    Capsule()
                        .frame(width: max(3, geo.size.width / CGFloat(viewModel.levels.count) - 4), height: height)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .clipped()
    }
}
