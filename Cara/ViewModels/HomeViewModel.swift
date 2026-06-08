//
//  HomeViewModel.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
class HomeViewModel {
	private var modelContext: ModelContext
	
	/// Collection of stored routines.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var routines: [Routine] = []
	
	/// Mapping of History by the Routine's ID.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var historiesDict: [UUID: History] = [:]
	
	/// Date variable for the selected day.
	///
	/// By default it will be today, change this value to update the historiesDict with the selected date.
	var selectedDay: Date = .now { didSet { self.fetchData(isOnlyHistories: true) } }
	
	/// Read only selected day for display
	var routineDay: Date {
		selectedDay
	}
	
	/// The earlieast recorded history.
	///
	/// Practically the first time the user opens the app.
	var earliestHistoryDate: Date = .now
	
	/// Fetch counter for SwiftUI update.
	var fetchCounter: Int = 0
	
	/// Variable to store routine name to add.
	var addRoutineName: String = ""
	
	/// Variable to store routine description to add.
	var addRoutineDescription: String = ""
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Delete a routine.
	///
	/// Use this to delete a routine, by passing the Routine object to this function.
	///
	/// > Warning: It is advisable to provide a confirmation dialog to delete, by calling this function inside that confirmation dialog's confirm button.
	///
	/// - Parameters:
	///   * routine: The Routine object to be deleted
	func deleteRoutine(routine: Routine) {
		self.modelContext.delete(routine)
		self.fetchData()
	}
	
	/// Populate viewmodel with data.
	///
	/// Use this function to populate data for this viewmodel.
	///
	/// > Tip: Use this in the parent component on a view with .task {}.
	///
	/// - Parameters:
	///   * isOnlyHistories: Only fetch histories, can safely ignore this.
	func fetchData(isOnlyHistories: Bool = false) {
		do {
			if !isOnlyHistories {
				self.routines = try fetchRoutines()
				self.earliestHistoryDate = try fetchEarliestHistoryDate()
			}
			self.historiesDict = try fetchHistoriesDict()
			self.fetchCounter += 1
		} catch {
			print("ERROR > Failed to fetch routines or histories: \(error)")
		}
	}
	
	/// Function to remove routine
	func removeRoutine(at offsets: IndexSet) {
		for index in offsets {
			let routineToRemove = routines[index]
			
			if let routineIndex = routines.firstIndex(of: routineToRemove) {
				self.modelContext.delete(routines[routineIndex])
				routines.remove(at: routineIndex)
			}
		}
	}
	
	/// Function to add routine from the stord variables.
	func addRoutine() {
		modelContext.insert( Routine(routineName: self.addRoutineName, routineDescription: self.addRoutineDescription))
		fetchData()
		
		self.addRoutineName = ""
		self.addRoutineDescription = ""
	}
	
	private func fetchRoutines() throws -> [Routine] {
		return try modelContext.fetch(FetchDescriptor<Routine>(
			sortBy: [SortDescriptor(\.timestamp, order: .forward)]
		))
	}
	
	private func fetchHistoriesDict() throws -> [UUID: History] {
		let startOfDay = Calendar.current.startOfDay(for: self.selectedDay)
		let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
		
		let currentHistoryPredicate = #Predicate<History> { history in
			history.date >= startOfDay && history.date < endOfDay
		}
		let fetchedHistories = try modelContext.fetch(FetchDescriptor<History>(predicate: currentHistoryPredicate))
		
		var historyDictionary = Dictionary(
			uniqueKeysWithValues: fetchedHistories.map { ($0.routine.id, $0) }
		)
		
		for routine in routines {
			if !historyDictionary.keys.contains(routine.id) {
				let newHistory = History(
					date: selectedDay,
					taskProgress: TaskProgress(filledAt: [:]),
					note: "",
					vital: Vital(),
					routine: routine
				)
				modelContext.insert(newHistory)
				historyDictionary[routine.id] = newHistory
			}
		}
		
		return historyDictionary
	}
	
	private func fetchEarliestHistoryDate() throws -> Date {
		var descriptor = FetchDescriptor<History>(
			sortBy: [SortDescriptor(\.date, order: .forward)]
		)
		descriptor.fetchLimit = 1
		
		let records = try modelContext.fetch(descriptor)
		return records.first?.date ?? .now
	}
}
