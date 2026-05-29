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
	
	init() {
		do {
			let modelContainer = try ModelContainer(for: Schema([Category.self, History.self, Routine.self, Task.self, Vital.self]))
			let modelContext = modelContainer.mainContext
			
			_homeViewModel = State(initialValue: HomeViewModel(modelContext: modelContext))
		} catch {
			fatalError("FATAL_ERROR > Failed to initialize SwiftData: \(error)")
		}
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(homeViewModel)
		}
	}
}
