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
	
	private var currentHistory: History? = nil
	
	/// The current task progress.
	///
	/// If the task UUID doesn't exist here treat it as unchecked. Use the date as filled at time.
	///
	/// > Tip: To check a task, set the task UUID here with .now
	var taskProgress: [UUID: Date] {
		get { currentHistory?.taskProgress.filledAt ?? [:] }
		set { currentHistory?.taskProgress.filledAt = newValue }
	}
	
	/// The vitals of the current Routine.
	///
	/// You can directly modify this data and SwiftData will automatically save it.
	var vital: Vital? {
		get { currentHistory?.vital }
		set {
			currentHistory?.vital = newValue
			currentHistory?.vitalFilledAt = (newValue != nil) ? Date.now : nil
		}
	}
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Populate viewmodel with data.
	///
	/// Use this function to populate data for this viewmodel.
	///
	/// > Tip: Use this in the parent component on a view with .task {}.
	///
	/// - Parameters:
	///   * routine: The selected routine to displayed.
	///   * day: The day selected for this routine.
	func fetchData(routine: Routine, day: Date) {
		do {
			let startOfDay = Calendar.current.startOfDay(for: day)
			let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
			
			let currentHistoryPredicate = #Predicate<History> { history in
				history.date >= startOfDay && history.date < endOfDay
			}
			let fetchedHistories = try modelContext.fetch(FetchDescriptor<History>(predicate: currentHistoryPredicate))
			
			self.currentHistory = fetchedHistories.first(where: { $0.routine.id == routine.id })
		} catch {
			print("ERROR > Failed populating routine history: \(error)")
		}
	}
}
