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
	
	// FIXME: make routine and historiesDict only read
	// FIXME: Docs for each public facing element
	var routines: [Routine] = []
	var historiesDict: [UUID: History] = [:]
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
	
	func changeSelectedDay(date: Date) {
		self.selectedDay = date
		self.fetchData()
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
		let currentHistoryDescriptor = FetchDescriptor<History>(predicate: currentHistoryPredicate)
		
		let fetchedHistories = try modelContext.fetch(currentHistoryDescriptor)
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
