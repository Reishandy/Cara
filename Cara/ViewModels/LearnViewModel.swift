//
//  LearnViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
class LearnViewModel {
	private var modelContext: ModelContext
	
	// FIXME: ReEvaluate filters, add new field or delete
	
	/// Collection of stored tasks dictionary, grouped by its category name.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var groupedTasks: [String: [RoutineTask]] = [:]
	
	/// Collection of stored categories.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var categories: [TaskCategory] = []
	
	/// Search term used to filter tasks by it's name.
	///
	/// To apply search / update tasks variable, update this variable with the desired search term.
	///
	/// > Tip: It is advised to use debounced search on the search field to improve performance.
	var searchTerm: String = "" { didSet { self.fetchData() } }
	
	/// Category filter used to filter tasks by it's category.
	///
	/// To apply search / update tasks variable, update this variable by adding or deleting TaskCategory inside.
	var categoryFilter: [TaskCategory] = [] { didSet { self.fetchData() } }
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Delete a task.
	///
	/// Use this to delete a task, by passing the Routinetask object to this function.
	///
	/// > Warning: It is advisable to provide a confirmation dialog to delete, by calling this function inside that confirmation dialog's confirm button.
	///
	/// - Parameters:
	///   * task: The RoutineTask object to be deleted
	func deleteTask(task: RoutineTask) {
		self.modelContext.delete(task)
		self.fetchData()
	}
	
	/// Populate viewmodel with data.
	///
	/// Use this function to populate data for this viewmodel.
	///
	/// > Tip: Use this in the parent component on a view with .task {}.
	func fetchData() {
		do {
			// A solution that works now because it is unrealistic to see a lot of tasks locally
			// So what I did is just fetch all and fitler in memory instead of dealing with Predicate...
			let search = self.searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
			let fetchedTasks = try modelContext.fetch(FetchDescriptor<RoutineTask>())
			
			let filteredTasks = fetchedTasks.filter { task in
				let matchesSearch = search.isEmpty || task.taskName.localizedStandardContains(search)
				let matchesCategory = self.categoryFilter.isEmpty || (task.category.map { self.categoryFilter.contains($0) } ?? false)
				
				return matchesSearch && matchesCategory
			}
			
			self.groupedTasks = Dictionary(grouping: filteredTasks, by: { $0.category?.categoryName ?? "Uncategorized" })
			self.categories = try modelContext.fetch(FetchDescriptor<TaskCategory>())
		} catch {
			print("ERROR > Failed to fetch tasks or categories: \(error)")
		}
	}
}
