//
//  Recordable.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import Foundation

protocol Recordable {
    func startNewRecording() throws
    func stopRecording()
    func pauseRecording()
    func resumeRecording()
}
