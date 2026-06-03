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
	/// This property can be read from anywhere, but can only be modified internally.
	private(set) var routines: [Routine] = []
	
	/// Mapping of History by the Routine's ID.
	///
	/// This property can be read from anywhere, but can only be modified internally.
	private(set) var historiesDict: [UUID: History] = [:]
	
	private var selectedDay: Date = .now
	
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
    
    var routineDay:  Date {
        selectedDay
    }
	
	/// Changes selected day for displaying history.
	///
	/// Use this to change the desired day of the history to view of the routintes, this will update the historiesDict variable.
	///
	/// - Parameters:
	///   * date: The date of the desired history to view.
	func changeSelectedDay(date: Date) {
		do {
			self.selectedDay = date
			self.historiesDict = try fetchHistoriesDict()
		} catch {
			print("ERROR > Failed to fetch histories: \(error)")
		}
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
	
	private func fetchData() {
		do {
			self.routines = try fetchRoutines()
			self.historiesDict = try fetchHistoriesDict()
		} catch {
			print("ERROR > Failed to fetch routines or histories: \(error)")
		}
	}
	
	private func fetchRoutines() throws -> [Routine] {
		return try modelContext.fetch(FetchDescriptor<Routine>())
	}
	
	private func fetchHistoriesDict() throws -> [UUID: History] {
		let startOfDay = Calendar.current.startOfDay(for: selectedDay)
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
					taskProgress: TaskProgress(status: [:]),
					note: "",
					routine: routine
				)
				modelContext.insert(newHistory)
				historyDictionary[routine.id] = newHistory
			}
		}
		
		return historyDictionary
	}
}
