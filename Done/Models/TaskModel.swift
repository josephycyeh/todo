//
//  TaskModel.swift
//  Done
//
//  Created by Joseph Yeh on 12/11/24.
//

import Foundation
struct DailyTaskModel: Identifiable {
    let id: UUID
    var title: String
    var completed: Bool
    
    init(id: UUID = UUID(), title: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}
