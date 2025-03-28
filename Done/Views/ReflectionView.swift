//
//  ReflectionView.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI

struct ReflectionView: View {
    @ObservedObject var dailyVM: DailyTasksViewModel
    var task: DailyTaskModel
    
    @State private var showCelebration = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Did you finish \(task.title)?")
                .font(.title2)
                .padding()
            
            HStack {
                Button("Yes") {
                    dailyVM.markTaskCompleted(task.id)
                    showCelebration = true
                }
                .padding()
                
                Button("Not Yet") {
                    dismiss()
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $showCelebration) {
            CelebrationView(dailyVM: dailyVM)
        }
    }
}
