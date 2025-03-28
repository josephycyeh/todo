//
//  EndOfDaySummaryView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct EndOfDaySummaryView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    
    var body: some View {
        let completedCount = dailyVM.tasks.filter { $0.completed }.count
        
        VStack {
            Text("Today's Summary")
                .font(.title)
            Text("You completed \(completedCount) out of \(dailyVM.tasks.count) tasks.")
                .padding()
            
            Text("Streak: \(dailyVM.streakCount) days")
                .padding()
            
            Button("Done for Today") {
                // User might wait until tomorrow, tasks reset next day.
            }
            .padding()
        }
    }
}
