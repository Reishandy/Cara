//
//  RoutineCard.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI
import SwiftData

struct RoutineCard: View {
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize

	@ScaledMetric(relativeTo: .body) private var horizontalSpacing = 24
	@ScaledMetric(relativeTo: .body) private var taskIconBackgroundSize = 28
	@ScaledMetric(relativeTo: .body) private var taskIconSize = 16

	let routine: Routine
	let history: History
	let selectedDay: Date

	private var bestTime: String {
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

	private var vitalColumns: [GridItem] {
		[GridItem(.adaptive(minimum: dynamicTypeSize.isAccessibilitySize ? 120 : 76), spacing: 8)]
	}

	var body: some View {
		NavigationLink(
			value: Screen.routineDetail(routine: routine, day: selectedDay)
		) {
			VStack(alignment: .leading, spacing: 16) {
				routineSummary
				vitalsGrid
				noteView
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(20)
			.background(Color.secondaryBackground)
			.cornerRadius(13)
		}
	}

	@ViewBuilder
	private var routineSummary: some View {
		if dynamicTypeSize.isAccessibilitySize {
			VStack(alignment: .leading, spacing: 12) {
				CircularProgressRing(
					total: history.routine.tasks.count,
					done: history.validCompletedTask.count
				)

				routineDescription
			}
		} else {
			HStack(alignment: .top, spacing: horizontalSpacing) {
				CircularProgressRing(
					total: history.routine.tasks.count,
					done: history.validCompletedTask.count
				)

				routineDescription
			}
		}
	}

	private var routineDescription: some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack(alignment: .top) {
				VStack(alignment: .leading, spacing: 4) {
					Text(routine.routineName)
						.font(.title2)
						.bold()
						.foregroundStyle(.appPrimary)
						.fixedSize(horizontal: false, vertical: true)
					Text(bestTime)
						.font(.subheadline)
						.foregroundStyle(.appThird)
						.fixedSize(horizontal: false, vertical: true)
				}

				Spacer(minLength: 8)

				Image(systemName: "chevron.right")
					.foregroundStyle(.appThird)
			}

			taskIconRow
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}

	private var taskIconRow: some View {
		HStack {
			ForEach(routine.tasks.prefix(5), id: \.self) { task in
				ZStack {
					Circle()
						.foregroundStyle(.appThird)
						.frame(width: taskIconBackgroundSize, height: taskIconBackgroundSize)

					Image(systemName: task.taskIcon)
						.resizable()
						.scaledToFit()
						.frame(width: taskIconSize, height: taskIconSize)
						.foregroundStyle(.white)
				}
			}

			if routine.tasks.count > 5 {
				Text("+\(routine.tasks.count - 5)")
					.font(.caption)
					.foregroundStyle(.appThird)
			}

			Spacer()
		}
	}

	@ViewBuilder
	private var vitalsGrid: some View {
		if !(history.vital?.isEmty ?? false) {
			if dynamicTypeSize.isAccessibilitySize {
				LazyVGrid(columns: vitalColumns, spacing: 8) {
					vitalCards
				}
				.frame(maxWidth: .infinity)
			} else {
				HStack(spacing: 8) {
					vitalCards
				}
				.frame(maxWidth: .infinity)
			}
		}
	}
	
	@ViewBuilder
	private var vitalCards: some View {
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

	@ViewBuilder
	private var noteView: some View {
		if !history.note.isEmpty {
			HStack(alignment: .top, spacing: 6) {
				Image(systemName: "text.pad.header")
				Text(history.note)
					.fixedSize(horizontal: false, vertical: true)
			}
			.font(.body)
			.foregroundStyle(.appThird)
		}
	}
}

struct VitalRoutineView: View {
	@ScaledMetric(relativeTo: .body) private var iconSize = 20
	@ScaledMetric(relativeTo: .body) private var cardPadding = 8

	let systemIcon: String
	let value: String
	let unit: String

	var body: some View {
		VStack(spacing: 4) {
			Image(
				systemName: systemIcon
			)
			.resizable()
			.scaledToFit()
			.frame(width: iconSize, height: iconSize)
			.foregroundStyle(.appPrimary)

			Text(value)
				.font(.headline)
				.foregroundStyle(.appPrimary)
				.bold()
				.fixedSize(horizontal: false, vertical: true)
			Text(unit)
				.font(.caption)
				.foregroundStyle(.appPrimary.opacity(0.7))
				.fixedSize(horizontal: false, vertical: true)
		}
		.frame(maxWidth: .infinity)
		.padding(cardPadding)
		.background(.appFourth)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

struct CircularProgressRing: View {
	@ScaledMetric(relativeTo: .body) private var ringSize = 55
	@ScaledMetric(relativeTo: .body) private var lineWidth = 12

	let total: Int
	let done: Int

	var body: some View {
		ZStack {
			// inactive part
			Circle()
				.stroke(
					Color.gray.opacity(0.25),
					lineWidth: lineWidth
				)

			// active part
			let progress = total == 0 ? 0 : CGFloat(done) / CGFloat(total)
			Circle()
				.trim(from: 0, to: progress)
				.stroke(
					Color.appPrimary,
					style: StrokeStyle(
						lineWidth: lineWidth,
						lineCap: .round
					)
				)
				.rotationEffect(.degrees(-90))

			Text("\(done)/\(total)")
				.font(.caption)
				.foregroundStyle(.appPrimary)
		}
		.frame(width: ringSize, height: ringSize)
	}
}

#Preview {
	let routine = Routine(
		routineName: "Taking care of my heart",
		routineDescription: "Take care of your heart",
		tasks: Array(RoutineTask.defaultData.prefix(4))
	)

	let history = History(
		date: .now,
		taskProgress: TaskProgress(filledAt: [UUID(): Date.now]),
		note: "Mama is here",
		vital: Vital(),
		routine: routine
	)

	NavigationStack {
		RoutineCard(routine: routine, history: history, selectedDay: .now)
	}
}

#Preview("Accessibility Text Scale") {
	let container = try! ModelContainer(
		for: Routine.self, RoutineTask.self, TaskCategory.self, History.self, Vital.self,
		configurations: ModelConfiguration(isStoredInMemoryOnly: true)
	)

	let routine = Routine(
		routineName: "Taking care of my heart with a longer routine name",
		routineDescription: "Take care of your heart",
		tasks: Array(RoutineTask.defaultData.prefix(6))
	)

	let history = History(
		date: Date.now,
		taskProgress: TaskProgress(filledAt: [UUID(): Date.now]),
		note: "Mama is here with a longer note to test wrapping at larger text sizes.",
		vital: Vital(),
		routine: routine
	)

	container.mainContext.insert(routine)
	container.mainContext.insert(history)

	let homeViewModel = HomeViewModel(modelContext: container.mainContext)

	return NavigationStack {
		RoutineCard(routine: routine, history: history, selectedDay: .now)
	}
	.environment(homeViewModel)
	.environment(\.dynamicTypeSize, .accessibility3)
	.modelContainer(container)
}
