//
//  Routine.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

@Model
class Routine: Hashable, Equatable {
	var id: UUID
	
	var routineName: String
	var routineDescription: String
	
	@Relationship(inverse: \Task.routines)
	var tasks: [Task] = []
	
	@Relationship(deleteRule: .cascade, inverse: \History.routine)
	var histories: [History] = []
	
	init(routineName: String, routineDescription: String, tasks: [Task] = []) {
		self.id = UUID()
		self.routineName = routineName
		self.routineDescription = routineDescription
		self.tasks = tasks
	}
}
