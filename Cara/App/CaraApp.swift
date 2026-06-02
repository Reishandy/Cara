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
	@State private var homeViewModel: HomeViewModel
	@State private var learnViewModel: LearnViewModel
	
	init() {
		do {
			let modelContainer = try ModelContainer(for: Schema([TaskCategory.self, History.self, Routine.self, RoutineTask.self, Vital.self]))
			let modelContext = modelContainer.mainContext
			
			_homeViewModel = State(initialValue: HomeViewModel(modelContext: modelContext))
			_learnViewModel = State(initialValue: LearnViewModel(modelContext: modelContext))
		} catch {
			fatalError("FATAL_ERROR > Failed to initialize SwiftData: \(error)")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(homeViewModel)
				.environment(learnViewModel)
		}
	}
}
