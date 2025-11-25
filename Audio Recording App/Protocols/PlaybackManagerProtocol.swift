//
//  PlaybackManagerProtocol.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 25.11.2025.
//

import Foundation

protocol PlaybackManagerProtocol {
    var state: PlaybackState { get }
    
    func load(url: URL) throws
    func play(item: LocalRecordingItem) throws
    func pause()
    func stop()
    func seek(to time: TimeInterval)
}
