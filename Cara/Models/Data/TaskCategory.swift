//
//  TaskCategory.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

@Model
class TaskCategory {
	var id: UUID
	
	var categoryName: String
	var isDefault: Bool
	
	@Relationship(deleteRule: .nullify, inverse: \RoutineTask.category)
	var tasks: [RoutineTask] = []
	
	init(categoryName: String, isDefault: Bool = false) {
		self.id = UUID()
		self.categoryName = categoryName
		self.isDefault = isDefault
	}
}
