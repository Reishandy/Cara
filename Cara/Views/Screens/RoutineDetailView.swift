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
	
	@State private var checkedTasks : [UUID: Date] = [:]
	
	
	var body: some View {
		ScrollView {
			VStack(spacing: 24) {
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
						VStack(alignment: .leading) {
							HStack(spacing: 8) {
								ZStack{
									Circle()
										.fill(Color("AppPrimaryColor"))
										.frame(width: 44, height: 44)
									Image(systemName:"waveform.path.ecg.text.clipboard.fill")
										.foregroundStyle(Color("BackgroundColor"))
										.font(.system(size: 22))
									
								}
								Text("Vitals Check")
									.foregroundStyle(Color("AppPrimaryColor"))
									.font(.system(size: 17, weight: .medium, design: .default))
							}
							
							
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
					
					VStack(spacing: 24) {
						if routine.tasks.isEmpty {
							VStack(spacing: 8) {
								Text("No Tasks")
									.font(.title2)
									.bold()
									.foregroundStyle(.secondary)
								Text("Start by adding a task")
									.font(.subheadline)
									.foregroundStyle(.secondary)
								
							}
							.frame(maxWidth: .infinity)
							.padding(.vertical, 90)
						}
						else {
							VStack(spacing: 12) {
								ForEach(routine.tasks) { task in
									TaskCardView(
										taskName: task.taskName,
										style: checkedTasks[task.id] != nil ? .checked : .uncheckedCircle, onButtonClick: {
											if checkedTasks[task.id] != nil {
												checkedTasks[task.id] = nil
											} else {
												checkedTasks[task.id] = Date()
											}
										},
										clickTime: checkedTasks[task.id]
									)
								}
							}
						}
					}
					
				case .note:
					Text("Describe what happened")
						.font(.title2)
						.foregroundStyle(Color.appPrimary)
						.bold()
						.frame(maxWidth: .infinity, alignment: .leading)
					
					ZStack(alignment: .bottomTrailing) {
						RoundedRectangle(cornerRadius: 16)
							.fill(Color.background.opacity(0.8))
						
						VStack(alignment: .leading, spacing: 0) {
							TextEditor(text: $noteText)
								.foregroundStyle(.appPrimary)
								.scrollContentBackground(.hidden)
								.padding(16)
								.onChange(of: noteText) {
									lastEditedDate = Date()
								}
							
							if let date = lastEditedDate {
								Text("✓ Last edited at: \(date.formatted(date: .omitted, time: .shortened))")
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
			.padding(.horizontal, 20)
		}
		.toolbar {
			// Title
			ToolbarItem(placement: .principal) {
				VStack(spacing: 2) {
					TextField("Routine name", text: $routine.routineName)
						.font(.title3)
						.bold()
						.multilineTextAlignment(.center)
						.foregroundStyle(Color.appPrimary)
					Text(selectedDay.formatted(date: .long, time: .omitted))
						.font(.caption)
						.foregroundStyle(.appThird)
				}
			}
			
			// Add Task button
			ToolbarItem(placement: .bottomBar) {
				if currentElement == .task && routine.tasks.isEmpty {
					Button {
						///
					} label: {
						Text("Add Task")
							.font(.headline)
							.foregroundStyle(.white)
					}
					.frame(maxWidth: .infinity)
					.buttonStyle(.borderedProminent)
					.tint(Color("AppThirdColor"))
				}
			}
			
			// Edit button
			ToolbarItem(placement: .navigationBarTrailing) {
				if currentElement == .task && !routine.tasks.isEmpty {
					Button {
						// FIXME: Edit
					} label: {
						Text("Edit")
							.foregroundColor(Color("AppPrimaryColor"))
						
					}
					
				}
			}
			
			
		}
		.navigationBarTitleDisplayMode(.inline)
		.onAppear{
			UISegmentedControl.appearance().backgroundColor = UIColor.appThird.withAlphaComponent(0.15)
			UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.appThird
			UISegmentedControl.appearance().setTitleTextAttributes(
				[.foregroundColor: UIColor.white],
				for: .selected
			)
			UISegmentedControl.appearance().setTitleTextAttributes(
				[.foregroundColor: UIColor.appPrimary],
				for: .normal
			)
		}
	}
}

#Preview("Empty State") {
	NavigationStack {
		RoutineDetailView(
			routine: Routine(
				routineName: "Morning Routine",
				routineDescription: "Every Morning"
			), selectedDay: .now
		)
	}
}


#Preview("Filled State") {
	NavigationStack {
		RoutineDetailView(
			routine: Routine(
				routineName: "Morning Routine",
				routineDescription: "Every Morning",
				tasks: [
					RoutineTask(taskName: "Assisted Hip & Knee Flexion", howTo: []),
					RoutineTask(taskName: "Scheduled Medication", howTo: []),
					RoutineTask(taskName: "Tongue In-and-Outs", howTo: [])
				]
			),
			selectedDay: .now
		)
	}
}
