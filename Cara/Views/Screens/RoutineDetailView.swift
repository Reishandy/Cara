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
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize

	@Bindable var routine: Routine
	let selectedDay: Date

	@ScaledMetric(relativeTo: .body) private var vitalHeaderIconBackgroundSize = 44
	@ScaledMetric(relativeTo: .body) private var vitalHeaderIconSize = 22

	@State private var currentElement: RoutineDetailElement = .task

	@State private var vitalFilledDate: Date? = nil
	@State private var bloodPressure: String = ""
	@State private var heartRate: String = ""
	@State private var temperature: String = ""
	@State private var oxygenLevel: String = ""

	@State private var noteText: String = ""
	@State private var lastEditedDate: Date? = nil

	@State private var checkedTasks: [UUID: Date] = [:]

	private let vitalColumns = [GridItem(.adaptive(minimum: 120), spacing: 8)]

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
					taskSection
				case .note:
					noteSection
				}

				Spacer()
			}
			.padding(.horizontal, 20)
		}
		.toolbar {
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
		.onAppear {
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

	private var taskSection: some View {
		VStack(spacing: 24) {
			vitalsSection
			tasksList
		}
	}

	private var vitalsSection: some View {
		VStack(spacing: 24) {
			VStack(alignment: .leading) {
				HStack(spacing: 8) {
					ZStack {
						Circle()
							.fill(Color("AppPrimaryColor"))
							.frame(
								width: vitalHeaderIconBackgroundSize,
								height: vitalHeaderIconBackgroundSize
							)
						Image(systemName:"waveform.path.ecg.text.clipboard.fill")
							.foregroundStyle(Color("BackgroundColor"))
							.font(.system(size: vitalHeaderIconSize))
					}
					Text("Vitals Check")
						.foregroundStyle(Color("AppPrimaryColor"))
						.font(.headline)
						.fixedSize(horizontal: false, vertical: true)
				}

				vitalsInputLayout

				if let date = vitalFilledDate {
					HStack(alignment: .top) {
						Image(systemName: "clock")
						Text("Filled at \(date.formatted(date: .omitted, time: .shortened))")
							.fixedSize(horizontal: false, vertical: true)
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
	}

	@ViewBuilder
	private var tasksList: some View {
		VStack(spacing: 24) {
			if routine.tasks.isEmpty {
				VStack(spacing: 8) {
					Text("No Tasks")
						.font(.title2)
						.bold()
						.foregroundStyle(.secondary)
						.fixedSize(horizontal: false, vertical: true)
					Text("Start by adding a task")
						.font(.subheadline)
						.foregroundStyle(.secondary)
						.fixedSize(horizontal: false, vertical: true)
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 90)
			} else {
				VStack(spacing: 12) {
					ForEach(routine.tasks) { task in
						TaskCardView(
							taskName: task.taskName,
							style: checkedTasks[task.id] != nil ? .checked : .uncheckedCircle,
							onButtonClick: {
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
	}

	private var noteSection: some View {
		VStack(spacing: 24) {
			Text("Describe what happened")
				.font(.title2)
				.foregroundStyle(Color.appPrimary)
				.bold()
				.fixedSize(horizontal: false, vertical: true)
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
							.fixedSize(horizontal: false, vertical: true)
							.padding([.bottom, .leading], 16)
					}
				}
			}
			.frame(minHeight: 240)
		}
	}

	@ViewBuilder
	private var vitalsInputLayout: some View {
		if dynamicTypeSize.isAccessibilitySize {
			LazyVGrid(columns: vitalColumns, spacing: 8) {
				vitalInputFields
			}
		} else {
			HStack(spacing: 8) {
				vitalInputFields
			}
		}
	}

	@ViewBuilder
	private var vitalInputFields: some View {
		VitalPillView(
			unit: "mm HG",
			systemIcon: "blood.pressure.cuff",
			value: $bloodPressure
		)
		.onChange(of: bloodPressure) {
			vitalFilledDate = Date()
		}

		VitalPillView(
			unit: "bpm",
			systemIcon: "waveform.path.ecg",
			value: $heartRate
		)
		.onChange(of: heartRate) {
			vitalFilledDate = Date()
		}

		VitalPillView(
			unit: "℃",
			systemIcon: "thermometer.variable",
			value: $temperature
		)
		.onChange(of: temperature) {
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
