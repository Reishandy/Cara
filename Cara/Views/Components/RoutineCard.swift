//
//  RoutineCard.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI
import SwiftData

struct RoutineCard: View {
	let routine: Routine
	let history: History
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			// FIXME: Do we need this?
			Text(routine.routineName)
				.font(.title)
				.bold()
				.foregroundStyle(.appPrimary)
			
			RoutineBody(routine: routine, history: history)
		}
	}
}

private struct RoutineBody: View {
	@Environment(HomeViewModel.self) var homeViewModel
	
	let routine: Routine
	let history: History
	
	// FIXME: Do we need this?
	var bestTime: String {
		"Best time: 05:00 - 11:59"
	}
	
	private var bpString: String {
		history.vital?.bloodPressure.map { "\($0.systolic)/\($0.diastolic)" } ?? "-/-"
	}
	private var hrString: String {
		history.vital?.heartRate.map(String.init) ?? "-"
	}
	private var tempString: String {
		history.vital?.temperature.map { String(format: "%.1f", $0) } ?? "-"
	}
	private var o2String: String {
		history.vital?.oxygenSaturation.map(String.init) ?? "-"
	}
	
	var body: some View {
		NavigationLink(
			value: Screen.routineDetail(routine: routine, day: homeViewModel.selectedDay)
		) {
			VStack(alignment: .leading) {
				HStack {
					CircularProgressRing(
						total: history.routine.tasks.count,
						done: history.validCompletedTask.count
					)
					
					Spacer().frame(width: 24)
					
					VStack {
						HStack(alignment: .top) {
							VStack(alignment: .leading) {
								Text(routine.routineName)
									.font(.title2)
									.bold()
									.foregroundStyle(.appPrimary)
								Text(bestTime)
									.font(.subheadline)
									.foregroundStyle(.appThird)
							}
							
							Spacer()
							
							Image(systemName: "chevron.right")
								.foregroundStyle(.appThird)
						}
						
						HStack {
							ForEach(routine.tasks, id: \.self) { task in
								ZStack {
									Circle()
										.foregroundStyle(.appThird)
										.frame(width: 28)
									
									Image(systemName: task.taskIcon)
										.resizable()
										.scaledToFit()
										.frame(width: 16)
										.foregroundStyle(.white)
								}
							}
							
							if routine.tasks.count > 5 {
								Text("+\(routine.tasks.count - 5)")
									.foregroundStyle(.appThird)
							}
							
							Spacer()
						}
					}
				}
				
				Spacer().frame(height: 16)
				
				HStack {
					VitalRoutineView(
						systemIcon: "blood.pressure.cuff",
						value: bpString,
						unit: "mm Hg"
					)
					
					VitalRoutineView(
						systemIcon: "waveform.path.ecg",
						value: hrString,
						unit: "bpm"
					)
					
					VitalRoutineView(
						systemIcon: "thermometer.variable",
						value: tempString,
						unit: "℃"
					)
					
					VitalRoutineView(
						systemIcon: "lungs",
						value: o2String,
						unit: "%"
					)
				}
				.frame(maxWidth: .infinity)
				
				Spacer().frame(height: 16)
				
				if !history.note.isEmpty {
					HStack {
						Image(systemName: "text.pad.header")
						Spacer()
							.frame(width: 6)
						Text(history.note)
					}
					.foregroundStyle(.appThird)
				}
			}
			.frame(maxWidth: .infinity)
			.padding(20)
			.background(Color.secondaryBackground)
			.cornerRadius(13)
		}
	}
}

struct VitalRoutineView: View {
	let systemIcon: String
	let value: String
	let unit: String
	
	var body: some View {
		VStack {
			Image(
				systemName: systemIcon
			)
			.resizable()
			.scaledToFit()
			.frame(width: 20, height: 20)
			.foregroundStyle(.appPrimary)
			
			Text(value)
				.foregroundStyle(.appPrimary)
				.bold()
			Text(unit)
				.foregroundStyle(.appPrimary.opacity(0.7))
		}
		.frame(width: 60)
		.padding(8)
		.background(.appFourth)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

struct CircularProgressRing: View {
	let total: Int
	let done: Int
	
	var body: some View {
		ZStack {
			// inactive part
			Circle()
				.stroke(
					Color.gray.opacity(0.25),
					lineWidth: 12
				)
			
			// active part
			let progress = total == 0 ? 0 : CGFloat(done) / CGFloat(total)
			Circle()
				.trim(from: 0, to: progress)
				.stroke(
					Color.appPrimary,
					style: StrokeStyle(
						lineWidth: 12,
						lineCap: .round
					)
				)
				.rotationEffect(.degrees(-90))
			
			Text("\(done)/\(total)")
				.foregroundStyle(.appPrimary)
		}
		.frame(width: 55, height: 55)
	}
}

#Preview {
	let container = try! ModelContainer(
		for: Routine.self, RoutineTask.self, TaskCategory.self, History.self, Vital.self,
		configurations: ModelConfiguration(isStoredInMemoryOnly: true)
	)
	
	let routine = Routine(
		routineName: "Taking care of my heart",
		routineDescription: "Take care of your heart",
		tasks: Array(RoutineTask.defaultData.prefix(4))
	)
	
	let history = History(
		date: Date.now,
		taskProgress: TaskProgress(filledAt: [UUID(): Date.now]),
		note: "Mama is here",
		vital: Vital(),
		routine: routine
	)
	
	container.mainContext.insert(routine)
	container.mainContext.insert(history)
	
	let homeViewModel = HomeViewModel(modelContext: container.mainContext)
	
	return NavigationStack {
		RoutineCard(routine: routine, history: history)
	}
	.environment(homeViewModel)
	.modelContainer(container)
}
