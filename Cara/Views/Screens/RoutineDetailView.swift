//
//  RoutineDetailView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI
import SwiftData

enum RoutineDetailElement {
	case task
	case note
}

struct RoutineDetailView: View {
	@Environment(\.editMode) private var editMode
	@Environment(\.dismiss) private var dismiss
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize
	
	@Environment(RoutineDetailViewModel.self) var routineDetailViewModel
	
	@Bindable var routine: Routine
	let selectedDay: Date
	
	@ScaledMetric(relativeTo: .body) private var vitalHeaderIconBackgroundSize = 44
	@ScaledMetric(relativeTo: .body) private var vitalHeaderIconSize = 22
	
	@State private var currentElement: RoutineDetailElement = .task
	@State private var showTaskSelection = false
	@State private var showDeleteConfirmation = false
	
	private var isEdit: Bool {
		editMode?.wrappedValue == .active
	}
	
	private let vitalColumns = [GridItem(.adaptive(minimum: 120), spacing: 8)]
	
	var body: some View {
		ZStack(alignment: .top) {
			switch currentElement {
			case .task:
				taskSection
					.padding(.top, isEdit ? 0 : 70)
			case .note:
				noteSection
					.padding(.top, 70)
					.padding(.horizontal, 20)
			}
			
			if !isEdit {
				Picker("Routine Detail Element", selection: $currentElement) {
					Text("Task")
						.tag(RoutineDetailElement.task)
					
					Text("Note")
						.tag(RoutineDetailElement.note)
				}
				.pickerStyle(.segmented)
				.padding(.top, 16)
				.padding(.horizontal, 20)
			}
		}
		.toolbar {
			ToolbarItem(placement: .principal) {
				VStack(spacing: 2) {
					Text(routine.routineName)
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
				if currentElement == .task && (routine.tasks.isEmpty || isEdit) {
					Button {
						showTaskSelection = true
					} label: {
						Text(routine.tasks.isEmpty ? "Add Task" : "Modify Task")
							.font(.headline)
							.foregroundStyle(.white)
							.multilineTextAlignment(.center)
					}
					.frame(maxWidth: .infinity)
					.buttonStyle(.borderedProminent)
					.tint(Color("AppThirdColor"))
				}
			}
			
			ToolbarItem(placement: .topBarTrailing) {
				if isEdit {
					Button {
						showDeleteConfirmation = true
					} label: {
						Image(systemName: "trash")
							.foregroundStyle(.red)
					}
					.confirmationDialog(
						"Delete",
						isPresented: $showDeleteConfirmation
					) {
						Button("Delete Routine", role: .destructive) {
							dismiss()
							routineDetailViewModel.deleteRoutine(routine: routine)
						}
						.buttonStyle(.bordered)
					} message: {
						Text("This action will delete this routine alongside its associated vitals recording, notes, and task progresion. Are you sure? this action cannot be undone.")
					}
				}
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				if currentElement == .task {
					EditButton()
				}
			}
		}
		.toolbar(.hidden, for: .tabBar)
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
		.task {
			routineDetailViewModel.fetchData(routine: routine, day: selectedDay)
		}
		.navigationDestination(isPresented: $showTaskSelection) {
			TaskSelectionView(
				initialTasks: routine.tasks,
				onSaveAction: { tasks in
					routine.tasks = tasks
					routine.taskOrder = tasks.map { $0.id }
				},
				isEdit: isEdit
			)
		}
	}
	
	private var taskSection: some View {
		List {
			if !isEdit {
				vitalsSection
					.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 12, trailing: 0))
					.listRowSeparator(.hidden)
					.listRowBackground(Color.clear)
                    .padding(.horizontal, 20)
			}
			
			if isEdit {
				ItemFormView(name: $routine.routineName, description: $routine.routineDescription)
					.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 12, trailing: 0))
					.listRowSeparator(.hidden)
					.listRowBackground(Color.clear)
                    .padding(.horizontal, 20)
			}
			
			tasksList
                .padding(.horizontal, 20)
		}
		.listStyle(.plain)
	}
	
	private var vitalsSection: some View {
		VStack(spacing: 24) {
			VStack(alignment: .leading) {
				HStack(spacing: 8) {
					ZStack {
						Circle()
							.fill(.secondaryBackground)
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
				
				if let date = routineDetailViewModel.vitalFilledDate {
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
			.padding(.top, 120)
			.listRowSeparator(.hidden)
			.listRowBackground(Color.clear)
		} else {
			ForEach(routine.orderedTasks) { task in
				ZStack {
					NavigationLink {
						TaskDetailView(task: task)
					} label: {
						EmptyView()
					}
					.opacity(0)
					
					TaskCardView(
						taskName: task.taskName,
						taskIconEach: task.taskIcon,
						style: isEdit ? .noButton : (routineDetailViewModel.taskProgress[task.id] != nil ? .checkedOnly : .uncheckedCircle),
								if routineDetailViewModel.taskProgress[task.id] != nil {
									routineDetailViewModel.taskProgress[task.id] = nil
								} else {
									routineDetailViewModel.taskProgress[task.id] = Date()
								}
							}
						},
						clickTime: isEdit ? nil : routineDetailViewModel.taskProgress[task.id]
					)
				}
			}
			.onDelete(perform: routineDetailViewModel.removeTasks)
			.onMove(perform: routineDetailViewModel.moveTasks)
			.listRowSeparator(.hidden)
			.listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
		}
	}
	
	private var noteSection: some View {
		@Bindable var routineDetailViewModel = self.routineDetailViewModel
		
		return VStack(spacing: 12) {
			Text("Describe what happened")
				.font(.title2)
				.foregroundStyle(Color.appPrimary)
				.bold()
				.fixedSize(horizontal: false, vertical: true)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			ZStack(alignment: .bottomTrailing) {
				RoundedRectangle(cornerRadius: 16)
					.fill(Color.selected.opacity(0.8))
				
				VStack(alignment: .leading, spacing: 0) {
					TextEditor(text: $routineDetailViewModel.note)
						.foregroundStyle(.appPrimary)
						.scrollContentBackground(.hidden)
						.padding(16)
					
					if let date = routineDetailViewModel.noteFilledDate {
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
		@Bindable var routineDetailViewModel = self.routineDetailViewModel
		
		VitalPillView(
			name: "Blood Pressure",
			unit: "mm HG",
			systemIcon: "blood.pressure.cuff",
			isBp: true,
			value: Binding(
				get: {
					guard let bloodPressure = routineDetailViewModel.vital.bloodPressure else { return "" }
					return "\(bloodPressure.systolic)/\(bloodPressure.diastolic)"
				},
				set: { newValue in
					let components = newValue.components(separatedBy: "/")
					if components.count == 2,
					   let systolic = Int(components[0].trimmingCharacters(in: .whitespaces)),
					   let diastolic = Int(components[1].trimmingCharacters(in: .whitespaces)) {
						
						if routineDetailViewModel.vital.bloodPressure == nil {
							routineDetailViewModel.vital.bloodPressure = BloodPressure(systolic: systolic, diastolic: diastolic)
						} else {
							routineDetailViewModel.vital.bloodPressure?.systolic = systolic
							routineDetailViewModel.vital.bloodPressure?.diastolic = diastolic
						}
					}
				}
			)
		)
		
		VitalPillView(
			name: "Heart Rate",
			unit: "bpm",
			systemIcon: "waveform.path.ecg",
			value: Binding(
				get: {
					let heartRate = routineDetailViewModel.vital.heartRate ?? 0
					return heartRate > 0 ? String(heartRate) : ""
				},
				set: { routineDetailViewModel.vital.heartRate = Int($0) }
			)
		)
		
		VitalPillView(
			name: "Temperature",
			unit: "℃",
			systemIcon: "thermometer.variable",
			value: Binding(
				get: {
					let temperature = routineDetailViewModel.vital.temperature ?? 0
					return temperature > 0 ? String(temperature) : ""
				},
				set: { newValue in
					if newValue.isEmpty {
						routineDetailViewModel.vital.temperature = nil
					} else {
						let sanitized = newValue.replacingOccurrences(of: ",", with: ".")
						if let parsedFloat = Float(sanitized) {
							routineDetailViewModel.vital.temperature = parsedFloat
						}
					}
				}
			)
		)
		
		VitalPillView(
			name: "Oxygen Satur",
			unit: " %",
			systemIcon: "lungs",
			value: Binding(
				get: {
					let oxygenSaturation = routineDetailViewModel.vital.oxygenSaturation ?? 0
					return oxygenSaturation > 0 ? String(oxygenSaturation) : ""
				},
				set: { routineDetailViewModel.vital.oxygenSaturation = Int($0) }
			)
		)
	}
}

#Preview("Empty State") {
	let container = CaraApp.previewSharedContainer
	
	let routineDetailViewModel = RoutineDetailViewModel(modelContext: container.mainContext)
	
	NavigationStack {
		RoutineDetailView(
			routine: Routine(
				routineName: "Morning Routine",
				routineDescription: "Every Morning"
			), selectedDay: .now
		)
		.environment(routineDetailViewModel)
	}
}


#Preview("Filled State") {
	let container = CaraApp.previewSharedContainer
	
	let routineDetailViewModel = RoutineDetailViewModel(modelContext: container.mainContext)
	
	NavigationStack {
		RoutineDetailView(
			routine: Routine(
				routineName: "Morning Routine",
				routineDescription: "Every Morning",
				tasks: [
					RoutineTask(taskName: "Assisted Hip & Knee Flexion", taskDescription: "Desc", howTo: []),
					RoutineTask(taskName: "Scheduled Medication", taskDescription: "Desc", howTo: []),
					RoutineTask(taskName: "Tongue In-and-Outs", taskDescription: "Desc", howTo: [])
				]
			),
			selectedDay: .now
		)
		.environment(routineDetailViewModel)
	}
}
