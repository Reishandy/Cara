//
//  RoutineDetailViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData
import Combine

@Observable
@MainActor
class RoutineDetailViewModel {
	private var modelContext: ModelContext
	
	/// Selected routine for the current detail view.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var selectedRoutine: Routine? = nil
	
	/// Date variable for the selected day.
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var selectedDay: Date = .now
	
	/// The current task progress.
	///
	/// If the task UUID doesn't exist here
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	private(set) var taskProgress: [UUID: Date] = [:]
	
	/// The vitals of the current Routine.
	///
	/// You can directly modify this data and SwiftData will automatically save it.
	var vital: Vital? = nil
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Store selected routine and it's history for detail view.
	///
	/// Use this function to populate the RoutineDetailViewModel with the selected routine data, do this before moving to the detail screen.
	///
	/// - Parameters:
	///  * routine: The selected routine.
	///  * day: The selected day (Date), get this from the HomeViewModel.
	func selectRoutine(routine: Routine, day: Date) {
		self.selectedRoutine = routine
		self.selectedDay = day
		self.populateHistory()
	}
	
	// FIXME: Add function to check a task and set vital to update their filled at
	
	private func populateHistory() {
		do {
			let startOfDay = Calendar.current.startOfDay(for: .now)
			let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
			
			let currentHistoryPredicate = #Predicate<History> { history in
				history.date >= startOfDay && history.date < endOfDay
			}
			let fetchedHistories = try modelContext.fetch(FetchDescriptor<History>(predicate: currentHistoryPredicate))
			
			if let selectedHistory = fetchedHistories.filter({ history in
				history.routine == self.selectedRoutine
			}).first {
				self.taskProgress = selectedHistory.taskProgress.filledAt
				self.vital = selectedHistory.bindableVital
			}
		} catch {
			print("ERROR > Failed populating routine history: \(error)")
		}
	}
}
