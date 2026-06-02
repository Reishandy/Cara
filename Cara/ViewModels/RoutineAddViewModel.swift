//
//  RoutineAddViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData
import Combine

@Observable
@MainActor
class RoutineAddViewModel {
	private var modelContext: ModelContext
	private var cancellables = Set<AnyCancellable>()
	
	/// Collection of stored tasks.
	///
	/// This property can be read from anywhere, but can only be modified internally.
	private(set) var tasks: [RoutineTask] = []
	
	/// Selected Tasks in which to be added to a new Routine.
	var selectedTask: [RoutineTask] = []
	
	/// Routine Name in which to be set to a new Routine.
	var routineName: String = ""
	
	/// Routine Description in which to be set to a new Routine.
	var routineDescription: String = ""
	
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
	
	private func fetchData() {
		do {
			self.tasks = try modelContext.fetch(FetchDescriptor<RoutineTask>())
		} catch {
			print("ERROR > Failed to fetch tasks: \(error)")
		}
	}
}
