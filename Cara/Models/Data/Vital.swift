//
//  Vital.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation
import SwiftData

nonisolated struct BloodPressure: Codable {
	var systolic: Int
	var diastolic: Int
}

@Model
class Vital {
	var id: UUID
	
	var bloodPressure: BloodPressure?
	var heartRate: Int?
	var oxygenSaturation: Int?
	var temperature: Float?
	
	var history: History?
	
	init(bloodPressure: BloodPressure? = nil, heartRate: Int? = nil, oxygenSaturation: Int? = nil, temperature: Float? = nil, history: History? = nil) {
		self.id = UUID()
		self.bloodPressure = bloodPressure
		self.heartRate = heartRate
		self.oxygenSaturation = oxygenSaturation
		self.temperature = temperature
		self.history = history
	}
}
