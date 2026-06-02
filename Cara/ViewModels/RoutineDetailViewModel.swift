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
	
	// FIXME: Docs for each public facing element
	var selectedRoutine: Routine? = nil { didSet { self.populateHistory() } }
	var routineTaskProgress: TaskProgress? = nil
	var vital: Vital? = nil
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	private func populateHistory() {
		do {
			let selectedRoutine = self.selectedRoutine
			let startOfDay = Calendar.current.startOfDay(for: .now)
			let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
			
			let currentHistoryPredicate = #Predicate<History> { history in
				(history.date >= startOfDay && history.date < endOfDay) &&
				(history.routine == selectedRoutine)
			}
			let fetchedHistories = try modelContext.fetch(FetchDescriptor<History>(predicate: currentHistoryPredicate)).first
			
			self.routineTaskProgress = fetchedHistories?.taskProgress
			self.vital = fetchedHistories?.vital
		} catch {
			print("ERROR > Failed populating routine history: \(error)")
		}
	}
}
