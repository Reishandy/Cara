import SwiftUI
import SwiftData

@main
struct CaraApp: App {
	static let previewSharedContainer: ModelContainer = {
		do {
			let schema = Schema([TaskCategory.self, History.self, Routine.self, RoutineTask.self, Vital.self])
			
			let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
			let container = try ModelContainer(for: schema, configurations: [configuration])
			
			// FIXME: Remove history dummy
			let dummyCategory = TaskCategory(categoryName: "Dummy", isDefault: true)
			container.mainContext.insert(dummyCategory)
			
			let dummyVital = Vital(bloodPressure: BloodPressure(systolic: 1, diastolic: 1), temperature: 10.2)
			container.mainContext.insert(dummyVital)
			
			let dummyRoutine = Routine(routineName: "Dummy", routineDescription: "Dummy Routine")
			let dummyRoutine2 = Routine(routineName: "Dummy2", routineDescription: "Dummy Routine2 That is slightly long description and such")
			container.mainContext.insert(dummyRoutine)
			container.mainContext.insert(dummyRoutine2)
			
			let dummyTasks = [
				RoutineTask(taskName: "dummy", taskDescription: "Desc", taskIcon: "circle.fill", howTo: ["1", "2", "3"], isDefault: true, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: true, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory),
				RoutineTask(taskName: "dummy", taskDescription: "Desc", howTo: ["1", "2", "3"], isDefault: false, category: dummyCategory)
			]
			
			for task in dummyTasks {
				container.mainContext.insert(task)
				dummyRoutine.tasks.append(task)
			}
			
			let dummyHistory = History(
				date: .now,
				taskProgress: TaskProgress(
					filledAt: [
						dummyTasks[0].id: .now,
						dummyTasks[1].id: .now
					]
				),
				note: "This is a dummy note",
				vital: dummyVital,
				routine: dummyRoutine
			)
			
			let dummyHistory2 = History(
				date: .now,
				taskProgress: TaskProgress(filledAt: [:]),
				note: "This is a dummy note",
				vital: Vital(),
				routine: dummyRoutine2
			)
			
			container.mainContext.insert(dummyHistory)
			container.mainContext.insert(dummyHistory2)
			
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
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(homeViewModel)
				.environment(learnViewModel)
				.environment(routineDetailViewModel)
		}
	}
}
