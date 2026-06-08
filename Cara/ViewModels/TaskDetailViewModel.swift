//
//  TaskDetailViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 08/06/26.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
class TaskDetailViewModel {
	private var modelContext: ModelContext
	
	/// Collection of stored categories.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var categories: [TaskCategory] = []
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Populate viewmodel with data.
	///
	/// Use this function to populate data for this viewmodel.
	///
	/// > Tip: Use this in the parent component on a view with .task {}.
	func fetchData() {
		do {
			self.categories = try modelContext.fetch(FetchDescriptor<TaskCategory>())
		} catch {
			print("ERROR > Failed to fetch categories: \(error)")
		}
	}
	
	/// Function to remove task
	func deleteTask(task: RoutineTask) {
		modelContext.delete(task)
	}
}
