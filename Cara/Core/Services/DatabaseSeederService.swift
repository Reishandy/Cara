//
//  DatabaseSeederService.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftData

@MainActor
struct DatabaseSeederService {
	private var modelContext: ModelContext
	
	init(modelContext: ModelContext) {
		self.modelContext = modelContext
	}
	
	/// Seed an array of SwitData models.
	///
	/// Use this function to seed an array of SwiftData models by providing an array of SwiftData class type that implemented the Seedable protocol.
	///
	/// - Parameters:
	///   * modelTypes: an array of SwiftData class that implemented the Seedable protocol
	func seedIfEmpty(_ modelTypes: [any Seedable.Type]) {
		for modelType in modelTypes {
			seedModel(modelType)
		}
	}
	
	private func seedModel<T: Seedable>(_ modelType: T.Type) {
		do {
			let existingCount = try modelContext.fetchCount(FetchDescriptor<T>())
			guard existingCount == 0 else { return }
			
			let defaults = T.defaultData
			for item in defaults {
				modelContext.insert(item)
			}
			
			try modelContext.save()
		} catch {
			print("ERROR > Failed to seed \(T.self): \(error)")
		}
	}
}
