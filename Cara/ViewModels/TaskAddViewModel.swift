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
	
	// FIXME: Make only read
	// FIXME: Docs for each public facing element
	var categories: [TaskCategory] = []
	var taskName: String = ""
	var taskHowTo: [String] = []
	var taskImage: Data? = nil
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
	
	func saveTask() {
		// FIXME: optimize image here
		let newTask = RoutineTask(
			taskName: self.taskName,
			howTo: self.taskHowTo,
			image: self.taskImage,
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
