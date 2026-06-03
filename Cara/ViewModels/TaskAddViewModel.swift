//
//  TaskAddViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData
import Combine

@Observable
@MainActor
class TaskAddViewModel {
	// FIXME: Check if this is even needed
	private var modelContext: ModelContext
	private var cancellables = Set<AnyCancellable>()
	
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
		
		fetchData()
		
		// This will run fetchData everytime there is a database save action
		NotificationCenter.default.publisher(for: ModelContext.didSave)
			.sink { [weak self] _ in
				self?.fetchData()
			}
			.store(in: &cancellables)
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
	
	private func fetchData() {
		do {
			self.categories = try modelContext.fetch(FetchDescriptor<TaskCategory>())
		} catch {
			print("ERROR > Failed to fetch tasks: \(error)")
		}
	}
}
