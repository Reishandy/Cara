//
//  History.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

nonisolated struct TaskProgress: Codable {
	var filledAt: [UUID: Date]
}

@Model
class History {
	var id: UUID
	
	var date: Date
	var taskProgress: TaskProgress
	var note: String
	var vitalFilledAt: Date?
	
	@Relationship(deleteRule: .cascade, inverse: \Vital.history)
	var vital: Vital?
	var routine: Routine
	
	init(date: Date, taskProgress: TaskProgress, note: String, vital: Vital? = nil, routine: Routine) {
		self.id = UUID()
		self.date = date
		self.taskProgress = taskProgress
		self.note = note
		self.vital = vital
		self.routine = routine
	}
	
	var validCompletedTask: [UUID: Date] {
		let currentTaskIDs = Set(routine.tasks.map { $0.id })
		
		return taskProgress.filledAt.filter { taskID, _ in
			currentTaskIDs.contains(taskID)
		}
	}
}
