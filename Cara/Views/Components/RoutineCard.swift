//
//  RoutineCard.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI

struct RoutineCard: View {
	let routine: Routine
	let history: History
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
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
	
	var finishedTasks: [RoutineTask] {
		routine.tasks.filter { (task) -> Bool in
			task.isDefault
		}
	}
	
	var bestTime: String {
		"Best time: 05:00 - 11:59"
	}
	
	var body: some View {
		NavigationLink(
			value: Screen.routineDetail(routine: routine, day: homeViewModel.selectedDay)
		) {
			VStack(alignment: .leading) {
				HStack {
					CircularProgressRing(
						total: routine.tasks.count,
						done: finishedTasks.count)
					
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
									
									if let imageData = task.image,
									   !imageData.isEmpty,
									   let uiImage = UIImage(data: imageData) {
										Image(uiImage: uiImage)
											.resizable()
											.scaledToFit()
									}
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
					// FIXME: integrate w viewmodel
					//			^ Now can be done with homeviewmodel, just access the History.Vital
					if let vital = history.vital {
						VitalRoutineView()
						VitalRoutineView()
						VitalRoutineView()
						VitalRoutineView()
					}
				}
				
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
	var body: some View {
		VStack {
			Image(
				systemName: "square.and.arrow.down.badge.xmark.fill"
			)
			.resizable()
			.scaledToFit()
			.frame(width: 20, height: 20)
			.foregroundStyle(.appPrimary)
			
			Text("120/80")
				.foregroundStyle(.appPrimary)
				.bold()
			Text("mm Hg")
				.foregroundStyle(.appPrimary)
		}
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
