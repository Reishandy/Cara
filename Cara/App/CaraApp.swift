import SwiftUI
import SwiftData

@main
struct CaraApp: App {
	static let previewSharedContainer: ModelContainer = {
		do {
			let schema = Schema([TaskCategory.self, History.self, Routine.self, RoutineTask.self, Vital.self])
			
			let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
			let container = try ModelContainer(for: schema, configurations: [configuration])
			
			let seeder = DatabaseSeederService(modelContext: container.mainContext)
			seeder.seedIfEmpty([Routine.self, RoutineTask.self])
			
			return container
		} catch {
			fatalError("Failed to initialize Preview SwiftData Container: \(error)")
		}
	}()
	
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
	@State private var taskSelectViewModel = TaskSelectViewModel(modelContext: sharedContainer.mainContext)
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(homeViewModel)
				.environment(learnViewModel)
				.environment(routineDetailViewModel)
				.environment(taskSelectViewModel)
		}
	}
}
