//
//  LearnViewModel.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftUI
import SwiftData
import Combine

@Observable
@MainActor
class LearnViewModel {
	private var modelContext: ModelContext
	private var cancellables = Set<AnyCancellable>()
	
	// FIXME: ReEvaluate filters, add new field or delete
	// FIXME: Make only read
	// FIXME: Docs for each public facing element
	var tasks: [RoutineTask] = []
	var categories: [Category] = []
	var searchTerm: String = "" { didSet { self.fetchData() } }
	var categoryFilter: [Category] = [] { didSet { self.fetchData() } }
	
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
	
	private func fetchData() {
		do {
//			let taskPredicate = #Predicate<RoutineTask> { task in
//			}
			
			self.tasks = try modelContext.fetch(FetchDescriptor<RoutineTask>())
			self.categories = try modelContext.fetch(FetchDescriptor<Category>())
		} catch {
			print("ERROR > Failed to fetch tasks: \(error)")
		}
	}
}
