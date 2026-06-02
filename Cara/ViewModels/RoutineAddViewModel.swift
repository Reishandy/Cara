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
	
	// FIXME: Make only read
	// FIXME: Docs for each public facing element
	var tasks: [RoutineTask] = []
	var selectedTask: [RoutineTask] = []
	var routineName: String = ""
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
