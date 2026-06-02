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
	/// When a routine is set, this class will populate itself with the routine's today's taskProgress and vitals.
	var selectedRoutine: Routine? = nil { didSet { self.populateHistory() } }
	
	/// The current progress of selected routine.
	var routineTaskProgress: TaskProgress? = nil
	
	/// The current vitals of the selected routine.
	var vital: Vital? = nil
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	private func populateHistory() {
		do {
			let startOfDay = Calendar.current.startOfDay(for: .now)
			let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
			
			let currentHistoryPredicate = #Predicate<History> { history in
				history.date >= startOfDay && history.date < endOfDay
			}
			let fetchedHistories = try modelContext.fetch(FetchDescriptor<History>(predicate: currentHistoryPredicate))
			let selectedHistory = fetchedHistories.filter { history in
				history.routine == self.selectedRoutine
			}.first
			
			self.routineTaskProgress = selectedHistory?.taskProgress
			self.vital = selectedHistory?.vital
		} catch {
			print("ERROR > Failed populating routine history: \(error)")
		}
	}
}
