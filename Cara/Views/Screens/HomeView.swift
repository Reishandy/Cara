//
//  HomeView.swift
//  CH3-PM-Team4
//
//  Created by Fadil Himawan on 29/05/26.
//


import SwiftUI
import SwiftData
import UIKit

struct HomeView: View {
	@Environment(HomeViewModel.self) var homeViewModel
	
	@State private var showDatePicker = false
	
	var formattedDateString: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM yyyy"
		return formatter.string(from: homeViewModel.selectedDay)
	}
	
	var body: some View {
		VStack {
			// FIXME: Consider using toolbar and nav title?
			// 			^ Well tbh we need to redising if this is the case
			//			^ with the add button and all hehe
			HomeHeaderView()
			
			ScrollView {
				// FIXME: Consider putting it in a menu
				// FIXME: Add a limit, only selectable is today until latest history.
				// 			^ Now available in homeviewmodel
				Button {
					showDatePicker = true
				} label: {
					HStack {
						Text(formattedDateString)
						Spacer()
						Image(systemName: "chevron.down")
					}
					.padding(16)
					.background(Color.background)
					.cornerRadius(26)
					.foregroundStyle(.appPrimary)
					
				}.sheet(isPresented: $showDatePicker) {
					DatePicker(
						"Select Date",
						selection: Binding(
							get: {
								homeViewModel.routineDay
							},
							set: {
								homeViewModel.selectedDay = $0
							}
						),
						displayedComponents: .date
					)
					.datePickerStyle(.graphical)
					.padding()
					
				}
				
				
				ForEach(homeViewModel.routines, id: \.self) { routine in
					if let history = homeViewModel.historiesDict[routine.id] {
						RoutineCard(routine: routine, history: history)
					}
				}
				
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(16)
		.task {
			homeViewModel.fetchData()
		}
	}
	
}

struct HomeHeaderView: View {
	var body: some View {
		HStack(alignment: .center) {
			Text("Caregiving")
				.font(.largeTitle)
				.bold()
				.foregroundStyle(.appPrimary)
			
			Spacer()
			
			NavigationLink(
				value: Screen.routineAdd
			) {
				Image(systemName: "plus")
					.font(.system(size: 24, weight: .regular))
					.foregroundStyle(.white)
					.frame(width: 48, height: 48)
					.background(Color.appPrimary)
					.clipShape(Circle())
			}
		}
	}
}


#Preview {
	let container = try! ModelContainer(
		for: Routine.self, RoutineTask.self, TaskCategory.self, History.self, Vital.self,
		configurations: ModelConfiguration(isStoredInMemoryOnly: true)
	)
	
	container.mainContext.autosaveEnabled = false
	
	let tasks = Array(RoutineTask.defaultData.prefix(5))
	
	let routine = Routine(
		routineName: "Morning",
		routineDescription: "Routines to do in the morning.",
		tasks: tasks
	)
	
	let history = History(
		date: .now,
		taskProgress: TaskProgress(filledAt: [:]),
		note: "Mom is not happy",
		routine: routine
	)
	
	container.mainContext.insert(routine)
	container.mainContext.insert(history)
	
	let homeViewModel = HomeViewModel(
		modelContext: container.mainContext
	)
	
	return NavigationStack {
		HomeView()
	}
	.environment(homeViewModel)
	.modelContainer(container)
}
