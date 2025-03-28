//
//  CelebrationView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct CelebrationView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Great job!")
                .font(.largeTitle)
                .padding()
            
            // Placeholder for confetti animation
            Text("🎉")
                .font(.system(size: 80))
                .padding()
            
            Button("Done") {
                dailyVM.updateStreakIfNeeded()
                dismiss()
            }
            .padding()
        }
    }
}
