//
//  CaraApp.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI
import SwiftData

@main
struct CaraApp: App {
	@State private var databaseSeeder: DatabaseSeederService
	
	@State private var homeViewModel: HomeViewModel
	@State private var learnViewModel: LearnViewModel
	@State private var routineDetailViewModel: RoutineDetailViewModel
	@State private var routineAddViewModel: RoutineAddViewModel
	@State private var taskAddViewModel: TaskAddViewModel
	
	init() {
		do {
			let modelContainer = try ModelContainer(for: Schema([TaskCategory.self, History.self, Routine.self, RoutineTask.self, Vital.self]))
			let modelContext = modelContainer.mainContext
			
			self._databaseSeeder = State(initialValue: DatabaseSeederService(modelContext: modelContext))
			
			self._homeViewModel = State(initialValue: HomeViewModel(modelContext: modelContext))
			self._learnViewModel = State(initialValue: LearnViewModel(modelContext: modelContext))
			self._routineDetailViewModel = State(initialValue: RoutineDetailViewModel(modelContext: modelContext))
			self._routineAddViewModel = State(initialValue: RoutineAddViewModel(modelContext: modelContext))
			self._taskAddViewModel = State(initialValue: TaskAddViewModel(modelContext: modelContext))
			
			self.databaseSeeder.seedIfEmpty([Routine.self, RoutineTask.self])
		} catch {
			fatalError("FATAL_ERROR > Failed to initialize SwiftData: \(error)")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(homeViewModel)
				.environment(learnViewModel)
				.environment(routineDetailViewModel)
				.environment(routineAddViewModel)
				.environment(taskAddViewModel)
		}
	}
}
