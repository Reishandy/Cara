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
	var vital: Vital {
		get {
			currentHistory?.vital ?? Vital()
		}
		set {
			currentHistory?.vital = newValue
			currentHistory?.vitalFilledAt = Date.now
		}
		set {
			currentHistory?.note = newValue
			currentHistory?.noteFilledAt = Date.now
		}
	}
	
	/// The date vitals is filled
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	var vitalFilledDate: Date? {
		self.currentHistory?.vitalFilledAt
	}
	
	/// The date note is filled
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	var noteFilledDate: Date? {
		self.currentHistory?.noteFilledAt
	}
	
	/// The note of the current Routine.
	///
	/// You can directly modify this data and SwiftData will automatically save it.
	var note: String {
		get {
			currentHistory?.note ?? ""
		}
		set {
			currentHistory?.note = newValue
			currentHistory?.noteFilledAt = Date.now
		}
	}
	
	/// The date vitals is filled
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	var vitalFilledDate: Date? {
		self.currentHistory?.vitalFilledAt
	}
	
	/// The date note is filled
	///
	/// > Tip: This property can be read from anywhere, but can only be modified internally.
	var noteFilledDate: Date? {
		self.currentHistory?.noteFilledAt
	}
	
	private var routine: Routine?
	
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
			self.routine = routine
		} catch {
			print("ERROR > Failed populating routine history: \(error)")
		}
	}
	
	/// Function to sort tasks
	func moveTasks(from source: IndexSet, to destination: Int) {
		guard let routine = self.routine else { return }
		
		routine.taskOrder.move(fromOffsets: source, toOffset: destination)
	}
	
	/// Function to remove tasks
	func removeTasks(at offsets: IndexSet) {
		guard let routine = self.routine else { return }
		
		for index in offsets {
			let taskToRemove = routine.orderedTasks[index]
			
			if let orderIndex = routine.taskOrder.firstIndex(of: taskToRemove.id) {
				routine.taskOrder.remove(at: orderIndex)
			}
			
			if let relationshipIndex = routine.tasks.firstIndex(of: taskToRemove) {
				routine.tasks.remove(at: relationshipIndex)
			}
		}
	}
	
	/// Function to remove routine
	func removeRoutine(routine: Routine) {
		modelContext.delete(routine)
	}
}
