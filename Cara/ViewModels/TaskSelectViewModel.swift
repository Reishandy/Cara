//
//  TaskSelectViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 05/06/26.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
class TaskSelectViewModel {
	private var modelContext: ModelContext
	
	/// Collection of stored tasks dictionary, grouped by its category name.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var groupedTasks: [String: [RoutineTask]] = [:]
	
	/// Search term used to filter tasks by it's name.
	///
	/// To apply search / update tasks variable, update this variable with the desired search term.
	///
	/// > Tip: It is advised to use debounced search on the search field to improve performance.
	var searchTerm: String = "" { didSet { self.fetchData() } }
	
	/// Selected tasks.
	var selectedTasks: [RoutineTask] = []
	
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
			let search = self.searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
			let fetchedTasks = try modelContext.fetch(FetchDescriptor<RoutineTask>(
				sortBy: [SortDescriptor(\.taskName, order: .forward)]
			))
			
			let filteredTasks = fetchedTasks.filter { task in
				search.isEmpty || task.taskName.localizedStandardContains(search)
			}
			
			self.groupedTasks = Dictionary(grouping: filteredTasks, by: { $0.category?.categoryName ?? "Uncategorized" })
		} catch {
			print("ERROR > Failed to fetch tasks or categories: \(error)")
		}
	}
}
