//
//  TaskAddViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
class TaskAddViewModel {
	private var modelContext: ModelContext
	
	/// Collection of stored categories.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var categories: [TaskCategory] = []
	
	/// Task Name in which to be set to a new Task.
	var taskName: String = ""
	
	/// Task How Tos in which to be set to a new Task.
	///
	/// Set the How Tos by adding or deleting String from this variable Array.
	var taskHowTo: [String] = []
	
	/// Routine Image in which to be set to a new Task.
	///
	/// > Tip: use PhotosUI to get the desired photo
	var taskImage: Data? = nil
	
	/// Selected Categoru in which to be added to a new Task.
	var selectedCategory: TaskCategory? = nil
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Saves a new task.
	///
	/// Use this function to save a new task based on the set variables inside this class, when saved it will reset those variables.
	func saveTask() {
		let compressedImage = self.taskImage.map { ImageOptimizer.optimize(data: $0) }
		
		let newTask = RoutineTask(
			taskName: self.taskName,
			howTo: self.taskHowTo,
			image: compressedImage ?? nil,
			category: self.selectedCategory
		)
		
		self.modelContext.insert(newTask)
		
		self.taskName = ""
		self.taskHowTo = []
		self.taskImage = nil
		self.selectedCategory = nil
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
			print("ERROR > Failed to fetch tasks: \(error)")
		}
	}
}
