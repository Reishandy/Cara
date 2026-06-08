//
//  Routine.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

@Model
final class Routine: Seedable {
	var id: UUID
	var timestamp: Date
	
	var routineName: String
	var routineDescription: String
	var taskOrder: [UUID] = []
	
	@Relationship(inverse: \RoutineTask.routines)
	var tasks: [RoutineTask] = []
	
	@Relationship(deleteRule: .cascade, inverse: \History.routine)
	var histories: [History] = []
	
	init(routineName: String, routineDescription: String, tasks: [RoutineTask] = []) {
		self.id = UUID()
		self.timestamp = .now
		self.routineName = routineName
		self.routineDescription = routineDescription
		self.tasks = tasks
	}
	
	var orderedTasks: [RoutineTask] {
		taskOrder.compactMap { uuid in
			tasks.first { $0.id == uuid }
		}
	}
	
	static var defaultData: [Routine] {
		return [
			Routine(routineName: "Morning", routineDescription: "Routines to do in the morning."),
			Routine(routineName: "Afternoon", routineDescription: "Routines to do in the afternoon."),
			Routine(routineName: "Night", routineDescription: "Routines to do in the night.")
		]
	}
}
