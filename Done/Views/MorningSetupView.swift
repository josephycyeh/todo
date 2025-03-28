//
//  MorningSetupView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct MorningSetupView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    @State private var taskInputs: [String] = ["", "", ""]
    
    var body: some View {
        VStack {
            Text("Streak: \(dailyVM.streakCount) days")
                .font(.headline)
                .padding()
            
            Text("What are your top tasks today?")
                .font(.title2)
                .padding()
            
            ForEach(0..<3, id: \.self) { i in
                TextField("Task \(i+1)", text: $taskInputs[i])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
            
            Button("Confirm Tasks") {
                dailyVM.setTasks(taskInputs)
            }
            .padding()
        }
    }
}
