//
//  TaskListView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct TaskListView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    
    var body: some View {
        if let firstTask = dailyVM.tasks.first(where: { !$0.completed }) {
            // Show two-minute start prompt for first incomplete task
            TwoMinutePromptView(dailyVM: dailyVM, task: firstTask)
        } else {
            // All tasks done or no tasks?
            EndOfDaySummaryView(dailyVM: dailyVM)
        }
    }
}
