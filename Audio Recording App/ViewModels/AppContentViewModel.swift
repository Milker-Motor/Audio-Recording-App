//
//  AppContentViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI
import Combine

final class AppContentViewModel: ObservableObject {
    let recordable: Recordable
    let dataStore: RecordingDataStore
    private var cancellable = Set<AnyCancellable>()
    
    @Published var uiError: AppError?
    
    init(recordable: Recordable, dataStore: RecordingDataStore) {
        self.recordable = recordable
        self.dataStore = dataStore
    }
    
    lazy var detailContainerViewModel: DetailContainerViewModel = {
        let viewModel = DetailContainerViewModel(recordable: recordable, dataStore: dataStore, playback: PlaybackService(), detailMode: .none)
        
        viewModel.$detailMode
            .compactMap { value in
                if case let .playback(item) = value {
                    return item
                }
                return nil
            }
            .compactMap { $0 }
            .sink { [weak self] item in
                self?.sidebarViewModel.append(item)
            }.store(in: &cancellable)
        
        return viewModel
    }()
    
    lazy var sidebarViewModel: SidebarViewModel = {
        SidebarViewModel(dataStore: dataStore) { [weak self] in
            _ = try? self?.recordable.stopRecording()
            self?.recordable.state.startNewRecording()
            self?.detailContainerViewModel.detailMode = .recording
        } onSelect: { [weak self] item in
            self?.detailContainerViewModel.detailMode = .playback(item)
        }
    }()
}
