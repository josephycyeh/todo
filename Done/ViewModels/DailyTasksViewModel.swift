//
//  DailyTasksViewModel.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
import SwiftUI
import CoreData

class DailyTasksViewModel: ObservableObject {
    @Published var tasks: [DailyTaskModel] = []
    @Published var streakCount: Int = 0
    @Published var lastCompletionDate: Date?
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.viewContext) {
        self.context = context
        loadSettings()
        loadTodayTasks()
    }
    
    func loadSettings() {
        let request = NSFetchRequest<AppSettings>(entityName: "AppSettings")
        if let result = try? context.fetch(request), let settings = result.first {
            self.streakCount = Int(settings.streakCount)
            self.lastCompletionDate = settings.lastCompletionDate
        } else {
            // Create default settings if none exist
            let settings = AppSettings(context: context)
            settings.streakCount = 0
            settings.lastCompletionDate = nil
            try? context.save()
        }
    }
    
    func loadTodayTasks() {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let request = NSFetchRequest<DailyTask>(entityName: "DailyTask")
        request.predicate = NSPredicate(format: "date == %@", startOfDay as NSDate)
        
        if let results = try? context.fetch(request) {
            tasks = results.map {
                DailyTaskModel(id: $0.id ?? UUID(), title: $0.title ?? "", completed: $0.completed)
            }
        } else {
            tasks = []
        }
    }
    
    func saveTasks() {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        
        // Fetch existing
        let request = NSFetchRequest<DailyTask>(entityName: "DailyTask")
        request.predicate = NSPredicate(format: "date == %@", startOfDay as NSDate)
        let existing = (try? context.fetch(request)) ?? []
        
        // Delete existing to reset
        for e in existing { context.delete(e) }
        
        // Create new
        for t in tasks {
            let entity = DailyTask(context: context)
            entity.id = t.id
            entity.title = t.title
            entity.completed = t.completed
            entity.date = startOfDay
        }
        
        try? context.save()
    }
    
    func setTasks(_ newTasks: [String]) {
        tasks = newTasks
            .filter { !$0.isEmpty }
            .prefix(3)
            .map { DailyTaskModel(title: $0) }
        saveTasks()
    }
    
    func markTaskCompleted(_ taskId: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == taskId }) {
            tasks[index].completed = true
            saveTasks()
        }
    }
    
    func updateStreakIfNeeded() {
        // If at least one task completed, increment streak if new day
        let completedAny = tasks.contains { $0.completed }
        let today = Calendar.current.startOfDay(for: Date())
        
        if completedAny {
            if let lastDate = lastCompletionDate,
               Calendar.current.isDateInToday(lastDate) {
                // Already counted today
            } else {
                // Increment streak
                streakCount += 1
                lastCompletionDate = today
                saveSettings()
            }
        } else {
            // Reset streak if no tasks completed today
            streakCount = 0
            lastCompletionDate = nil
            saveSettings()
        }
    }
    
    private func saveSettings() {
        let request = NSFetchRequest<AppSettings>(entityName: "AppSettings")
        let settings = (try? context.fetch(request))?.first ?? AppSettings(context: context)
        settings.streakCount = Int64(streakCount)
        settings.lastCompletionDate = lastCompletionDate
        try? context.save()
    }
}
