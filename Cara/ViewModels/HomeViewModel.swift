//
//  HomeViewModel.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI
import SwiftData
import Combine

@Observable
@MainActor
class HomeViewModel {
	private var modelContext: ModelContext
	private var cancellables = Set<AnyCancellable>()
	
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
	}
	
	private func fetchData(isOnlyHistories: Bool = false) {
		do {
			if !isOnlyHistories {
				self.routines = try fetchRoutines()
			}
			self.historiesDict = try fetchHistoriesDict()
		} catch {
			print("ERROR > Failed to fetch routines or histories: \(error)")
		}
	}
	
	private func fetchRoutines() throws -> [Routine] {
		return try modelContext.fetch(FetchDescriptor<Routine>())
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
}
