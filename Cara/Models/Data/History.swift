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
final class History: Seedable { // FIXME: Remove placeholder
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
	
	static var defaultData: [History] {
		// FIXME: Remove dummy routine
		let dummyCategory = TaskCategory(categoryName: "Dummy", isDefault: true)
		let dummyTasks = [
			RoutineTask(taskName: "dummy", taskIcon: "circle.fill", howTo: ["1", "2", "3"], isDefault: true, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: true, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
			RoutineTask(taskName: "dummy", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory)
		]
		let dummyRoutine = Routine(routineName: "Dummy", routineDescription: "Dummy Routine", tasks: dummyTasks)
		let dummyRoutine2 = Routine(routineName: "Dummy2", routineDescription: "Dummy Routine2 That is slightly long description and such", tasks: dummyTasks)
		let dummyVital = Vital(bloodPressure: BloodPressure(systolic: 1, diastolic: 1), temperature: 10.2)
		
		return [
			History(
				date: .now,
				taskProgress: TaskProgress(
					filledAt: [
						dummyTasks[0].id: .now,
						dummyTasks[1].id: .now
					]
				),
				note: "This is a dummy note",
				vital: dummyVital,
				routine: dummyRoutine
			),
			History(
				date: .now,
				taskProgress: TaskProgress(filledAt: [:]),
				note: "This is a dummy note",
				vital: Vital(),
				routine: dummyRoutine2
			)
		]
	}
	
	var validCompletedTask: [UUID: Date] {
		let currentTaskIDs = Set(routine.tasks.map { $0.id })
		
		return taskProgress.filledAt.filter { taskID, _ in
			currentTaskIDs.contains(taskID)
		}
	}
}
