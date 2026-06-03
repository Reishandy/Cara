import SwiftUI
import SwiftData

@main
struct CaraApp: App {
	static let sharedContainer: ModelContainer = {
		do {
			let schema = Schema([TaskCategory.self, History.self, Routine.self, RoutineTask.self, Vital.self])
			let container = try ModelContainer(for: schema)
			
			let seeder = DatabaseSeederService(modelContext: container.mainContext)
			seeder.seedIfEmpty([Routine.self, RoutineTask.self])
			
			return container
		} catch {
			fatalError("FATAL_ERROR > Failed to initialize SwiftData: \(error)")
		}
	}()
	
	@State private var homeViewModel = HomeViewModel(modelContext: sharedContainer.mainContext)
	@State private var learnViewModel = LearnViewModel(modelContext: sharedContainer.mainContext)
	@State private var routineDetailViewModel = RoutineDetailViewModel(modelContext: sharedContainer.mainContext)
	@State private var routineAddViewModel = RoutineAddViewModel(modelContext: sharedContainer.mainContext)
	@State private var taskAddViewModel = TaskAddViewModel(modelContext: sharedContainer.mainContext)
	
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
