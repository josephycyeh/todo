import SwiftUI

struct ContentView: View {
    @StateObject var dailyVM = DailyTasksViewModel()
    
    var body: some View {

        
        if dailyVM.tasks.isEmpty {
            MorningSetupView(dailyVM: dailyVM)
        } else {
            TaskListView(dailyVM: dailyVM)
        }
    }
}

