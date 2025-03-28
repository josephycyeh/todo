//
//  FocusSessionViewModel.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI
import Combine

class FocusSessionViewModel: ObservableObject {
    @Published var remainingSeconds: Int = 25 * 60 // 25 min default
    @Published var isRunning = false
    
    var timerCancellable: AnyCancellable?
    
    func startSession() {
        isRunning = true
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tick()
            }
    }
    
    func tick() {
        if remainingSeconds > 0 {
            remainingSeconds -= 1
        } else {
            stopSession()
        }
    }
    
    func stopSession() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func reset() {
        stopSession()
        remainingSeconds = 25 * 60
    }
}
