//
//  Task.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

@Model
class Task: Hashable, Equatable {
	var id: UUID
	
	var taskName: String
	var howTo: [String]
	var isDefault: Bool
	
	@Attribute(.externalStorage) var image: Data?
	
	var category: Category?
	var routines: [Routine] = []
	
	init(taskName: String, howTo: [String], isDefault: Bool = false, image: Data? = nil, category: Category? = nil) {
		self.id = UUID()
		self.taskName = taskName
		self.howTo = howTo
		self.image = image
		self.isDefault = isDefault
		self.category = category
	}
}
