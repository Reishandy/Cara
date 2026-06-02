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
class Vital: Hashable, Equatable {
	var id: UUID
	
	// FIXME: Check what field is actualy used
	var bloodPressure: BloodPressure
	var heartRate: Int
	var oxygenSaturation: Int
	var temperature: Float
	var bloodSugarLevel: Int
	
	var history: History?
	
	init(bloodPressure: BloodPressure, heartRate: Int, oxygenSaturation: Int, temperature: Float, bloodSugarLevel: Int, history: History? = nil) {
		self.id = UUID()
		self.bloodPressure = bloodPressure
		self.heartRate = heartRate
		self.oxygenSaturation = oxygenSaturation
		self.temperature = temperature
		self.bloodSugarLevel = bloodSugarLevel
		self.history = history
	}
}
