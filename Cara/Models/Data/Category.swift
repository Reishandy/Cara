//
//  Category.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

@Model
class Category: Hashable, Equatable {
	var id: UUID
	
	var categoryName: String
	
	@Relationship(deleteRule: .nullify, inverse: \RoutineTask.category)
	var tasks: [RoutineTask] = []
	
	init(categoryName: String) {
		self.id = UUID()
		self.categoryName = categoryName
	}
}
