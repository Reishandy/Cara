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
	
	/// Selected tasks.
	var selectedTasks: [RoutineTask] = []
	
	/// Variable to store task name to add.
	var addTaskName: String = ""
	
	/// Variable to store task description to add.
	var addTaskDescription: String = ""
	
	/// Variable to store task category to add.
	var addTaskCategory: TaskCategory? = nil

	
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
			self.categories = try modelContext.fetch(FetchDescriptor<TaskCategory>())
		} catch {
			print("ERROR > Failed to fetch tasks or categories: \(error)")
		}
	}
	
	/// Function to add task from the stord variables.
	func addTask() {
		modelContext.insert( RoutineTask(taskName: self.addTaskName, taskDescription: self.addTaskDescription, howTo: [], category: self.addTaskCategory))
		fetchData()
		
		self.addTaskName = ""
		self.addTaskDescription = ""
		self.addTaskCategory = nil
	}
	
	/// Function to remove task
	func deleteTask(task: RoutineTask) {
		modelContext.delete(task)
	}
}
