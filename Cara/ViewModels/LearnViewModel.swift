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
	var categories: [TaskCategory] = []
	var searchTerm: String = "" { didSet { self.fetchData() } } // FIXME: Add warning on the doc to use bounce search
	var categoryFilter: [TaskCategory] = [] { didSet { self.fetchData() } }
	
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
	
	// FIXME: Possible task deletion here?
	
	private func fetchData() {
		do {
			// A solution that works now because it is unrealistic to see a lot of tasks locally
			// So what I did is just fetch all and fitler in memory instead of dealing with Predicate...
			let search = self.searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
			var fetchedTask = try modelContext.fetch(FetchDescriptor<RoutineTask>())
			
			self.tasks = fetchedTask.filter { task in
				let matchesSearch = search.isEmpty || task.taskName.localizedStandardContains(search)
				let matchesCategory = self.categoryFilter.isEmpty || (task.category.map { self.categoryFilter.contains($0) } ?? false)
				
				return matchesSearch && matchesCategory
			}
			self.categories = try modelContext.fetch(FetchDescriptor<TaskCategory>())
		} catch {
			print("ERROR > Failed to fetch tasks: \(error)")
		}
	}
}
