//
//  RecordingPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class RecordingPanelViewModel: ObservableObject {
    @Published private(set) var timer: String = "00:00"
}
