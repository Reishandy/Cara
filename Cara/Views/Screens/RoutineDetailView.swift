//
//  RoutineDetailView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI

enum RoutineDetailElement {
	case task
	case note
}

struct RoutineDetailView: View {
	@Bindable var routine: Routine
	let selectedDay: Date
	
	@State private var currentElement: RoutineDetailElement = .task
	
	@State private var vitalFilledDate: Date? = nil
	@State private var bloodPressure: String = ""
	@State private var heartRate: String = ""
	@State private var temperature: String = ""
	@State private var oxygenLevel: String = ""
	
	@State private var noteText: String = ""
	@State private var lastEditedDate: Date? = nil
	
	var body: some View {
		VStack(spacing: 24) {
			// FIXME: Filled indicator
			
			// FIXME: Day select color matching
			
			// FIXME: Change color and also font size
			Picker("Routine Detail Element", selection: $currentElement) {
				Text("Task")
					.tag(RoutineDetailElement.task)
				
				Text("Note")
					.tag(RoutineDetailElement.note)
			}
			.pickerStyle(.segmented)
			.padding(.top, 16)
			
			switch currentElement {
			case .task:
				VStack(spacing: 24) {
					HStack {
						Text("Check Vitals")
							.font(.title)
							.bold()
						
						Image(systemName: "questionmark.circle")
						
						Spacer()
					}
					
					VStack {
						HStack(spacing: 8) {
							VitalPillView(
								unit: "mm HG",
								systemIcon: "blood.pressure.cuff",
								value: $bloodPressure
								
							).onChange(of: bloodPressure) {
								vitalFilledDate = Date()
							}
							
							VitalPillView(
								unit: "bpm",
								systemIcon: "waveform.path.ecg",
								value: $heartRate
							).onChange(of: heartRate) {
								vitalFilledDate = Date()
							}
							
							VitalPillView(
								unit: "℃",
								systemIcon: "thermometer.variable",
								value: $temperature
							).onChange(of: temperature) {
								vitalFilledDate = Date()
							}
							
							VitalPillView(
								
								unit: " %",
								systemIcon: "lungs",
								value: $oxygenLevel
							)
							.onChange(of: oxygenLevel) {
								vitalFilledDate = Date()
							}
						}
						
						if let date = vitalFilledDate {
							HStack {
								Image(systemName: "clock")
								Text("Filled at \(date.formatted(date: .omitted, time: .shortened))")
							}
							.font(.caption)
							.padding(5)
							.foregroundStyle(Color.gray)
							.frame(maxWidth: .infinity, alignment: .leading)
						}
					}
					.padding(12)
					.background(Color.gray.opacity(0.1))
					.cornerRadius(12)
				}
				
				
				// FIXME: Tasks color matching
				VStack(spacing: 24) {
					HStack {
						Text("Tasks")
							.font(.title)
							.bold()
						
						Spacer()
					}
				}
				
			case .note:
				// FIXME: Note color matching
				Text("Notes")
					.font(.title)
					.bold()
					.frame(maxWidth: .infinity, alignment: .leading)
				
				ZStack(alignment: .bottomTrailing) {
					RoundedRectangle(cornerRadius: 16)
						.fill(Color.appThird.opacity(0.15))
					
					VStack(alignment: .leading, spacing: 0) {
						TextEditor(text: $noteText)
							.scrollContentBackground(.hidden)
							.padding(16)
							.onChange(of: noteText) {
								lastEditedDate = Date()
							}
						
						if let date = lastEditedDate {
							Text("Last edited: \(date.formatted(date: .abbreviated, time: .shortened))")
								.font(.caption)
								.foregroundStyle(.secondary)
								.padding([.bottom, .leading], 16)
						}
					}
					
				}
				.frame(maxHeight: .infinity)
			}
			
			Spacer()
		}
		.padding(.horizontal, 24)
		.toolbar {
			ToolbarItem(placement: .principal) {
				VStack(spacing: 2) {
					TextField("Routine name", text: $routine.routineName)
						.font(.title)
						.bold()
						.multilineTextAlignment(.center)
					Text(selectedDay.formatted(date: .long, time: .omitted))
						.font(.caption)
						.foregroundStyle(.appThird)
				}
			}
		}
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	NavigationStack {
		RoutineDetailView(
			routine: Routine(
				routineName: "Morning Routine",
				routineDescription: "Every Morning"
			),
			selectedDay: .now
		)
	}
}
