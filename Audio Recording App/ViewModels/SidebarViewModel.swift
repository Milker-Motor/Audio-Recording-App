//
//  SidebarViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class SidebarViewModel: ObservableObject {
    private let _onPlay: () -> Void
    init(onPlay: @escaping () -> Void) {
        self._onPlay = onPlay
    }
    
    func startNewRecording() {
        _onPlay()
    }
}
