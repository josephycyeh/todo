//
//  TwoMinutePromptView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct TwoMinutePromptView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    var task: DailyTaskModel
    
    @State private var showFocus = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Ready to start just 2 minutes on:")
                .font(.headline)
            Text(task.title)
                .font(.title)
                .bold()
            
            Button("Begin") {
                showFocus = true
            }
        }
        .fullScreenCover(isPresented: $showFocus) {
            FocusTimerView(dailyVM: dailyVM, task: task)
        }
    }
}
