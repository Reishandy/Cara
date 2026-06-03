//
//  RoutineAddViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
class RoutineAddViewModel {
	private var modelContext: ModelContext
	
	/// Collection of stored tasks dictionary, grouped by its category name.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var groupedTasks: [String: [RoutineTask]] = [:]
	
	/// Collection of stored categories.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var categories: [TaskCategory] = []
	
	/// Search term used to filter tasks by its name.
	///
	/// To apply search / update groupedTasks, set this property to the desired search term.
	///
	/// > Tip: Debounce updates on the search field to improve performance.
	var searchTerm: String = "" { didSet { self.fetchData() } }
	
	/// Category filter used to filter tasks by its category.
	///
	/// To apply filtering / update groupedTasks, modify this array by adding or removing TaskCategory values.
	var categoryFilter: [TaskCategory] = [] { didSet { self.fetchData() } }
	
	/// Selected Tasks in which to be added to a new Routine.
	var selectedTask: [RoutineTask] = []
	
	/// Routine Name in which to be set to a new Routine.
	var routineName: String = ""
	
	/// Routine Description in which to be set to a new Routine.
	var routineDescription: String = ""
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Saves a new routine.
	///
	/// Use this function to save a new routine based on the set variables inside this class, when saved it will reset those variables.
	func saveRoutine() {
		let newRoutine = Routine(
			routineName: self.routineName,
			routineDescription: self.routineDescription,
			tasks: self.selectedTask
		)
		
		self.modelContext.insert(newRoutine)
		
		self.selectedTask = []
		self.routineName = ""
		self.routineDescription = ""
	}
	
	/// Populate viewmodel with data.
	///
	/// Use this function to populate data for this viewmodel.
	///
	/// > Tip: Use this in the parent component on a view with .task {}.
	func fetchData() {
		do {
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
