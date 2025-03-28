//
//  FocusTimerView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct FocusTimerView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    var task: DailyTaskModel
    
    @StateObject var sessionVM = FocusSessionViewModel()
    @State private var showReflection = false
    
    var body: some View {
        VStack {
            Text(task.title)
                .font(.title2)
                .padding()
            
            Text("\(sessionVM.remainingSeconds/60) min \(sessionVM.remainingSeconds%60) sec")
                .font(.largeTitle)
                .padding()
            
            if sessionVM.isRunning {
                Button("Stop Early") {
                    sessionVM.stopSession()
                    showReflection = true
                }
            } else {
                Button("Start Focus") {
                    sessionVM.startSession()
                }
            }
        }
        .onChange(of: sessionVM.remainingSeconds) { newValue in
            if newValue == 0 {
                sessionVM.stopSession()
                showReflection = true
            }
        }
        .fullScreenCover(isPresented: $showReflection) {
            ReflectionView(dailyVM: dailyVM, task: task)
        }
    }
}
