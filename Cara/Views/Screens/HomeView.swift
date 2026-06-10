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
	@State private var showAddRoutineSheet = false
	
	private var formattedDateString: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM yyyy"
		return formatter.string(from: homeViewModel.selectedDay)
	}
	
	var body: some View {
		@Bindable var homeViewModel = self.homeViewModel
		
		ScrollView {
			VStack(alignment: .leading, spacing: 16) {
				Button {
					showDatePicker.toggle()
				} label: {
					HStack {
						Text(formattedDateString)
							.font(.body)
							.fixedSize(horizontal: false, vertical: true)
						Spacer()
						Image(systemName: "chevron.down")
							.imageScale(.medium)
							.rotationEffect(.degrees(showDatePicker ? -180 : 0))
							.animation(.snappy, value: showDatePicker)
					}
					.padding(16)
					.background(.capsule)
					.cornerRadius(26)
					.foregroundStyle(.appPrimary)
				}
				.popover(isPresented: $showDatePicker, arrowEdge: .top) {
					DatePicker(
						"Select Date",
						selection: Binding(
							get: { homeViewModel.routineDay },
							set: { homeViewModel.selectedDay = $0 }
						),
						in: homeViewModel.earliestHistoryDate...Date.now,
						displayedComponents: .date
					)
					.datePickerStyle(.graphical)
					.padding()
					.frame(width: 360, height: 340)
					.presentationCompactAdaptation(.popover)
				}
				
				Text("Routines")
					.font(.title)
					.bold()
					.foregroundStyle(.appPrimary)
					.fixedSize(horizontal: false, vertical: true)
				
				if homeViewModel.routines.isEmpty {
					VStack(spacing: 8) {
						Text("No Routines")
							.font(.title2)
							.bold()
							.foregroundStyle(.secondary)
							.fixedSize(horizontal: false, vertical: true)
						Text("Start by adding a routine")
							.font(.subheadline)
							.foregroundStyle(.secondary)
							.fixedSize(horizontal: false, vertical: true)
					}
					.frame(maxWidth: .infinity)
					.padding(.top, 230)
				} else {
					ForEach(homeViewModel.routines, id: \.self) { routine in
						if let history = homeViewModel.historiesDict[routine.id] {
							NavigationLink {
								RoutineDetailView(routine: routine, selectedDay: homeViewModel.selectedDay)
							} label: {
								RoutineCard(
									routine: routine,
									history: history
								)
								.id("\(routine.id)-\(homeViewModel.fetchCounter)")
								// Using this to force the component to update it's reference
							}
							.transition(.scale(0.8).combined(with: .opacity))
						}
					}
				}
			}
			.padding(.horizontal, 20)
		}
		.animation(.spring, value: homeViewModel.routines)
		.frame(maxWidth: .infinity, alignment: .leading)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					showAddRoutineSheet = true
				} label: {
					Image(systemName: "plus")
						.foregroundStyle(.appSecondary)
				}
				.buttonStyle(.borderedProminent)
				.tint(Color.background)
			}
		}
		.navigationTitle("Cara")
		.toolbarTitleDisplayMode(.inlineLarge)
		.sheet(isPresented: $showAddRoutineSheet) {
			VStack(spacing: 36) {
				HStack {
					Button {
						showAddRoutineSheet = false
					} label: {
						Text("Cancel")
							.font(.title3)
							.frame(width: 80)
					}
					.buttonStyle(.glass)
					
					Spacer()
					
					Button {
						showAddRoutineSheet = false
						homeViewModel.addRoutine()
					} label: {
						Text("Save")
							.font(.title3)
							.frame(width: 80)
					}
					.buttonStyle(.glassProminent)
					.disabled(homeViewModel.addRoutineName.isEmpty || homeViewModel.addRoutineDescription.isEmpty)
				}
				
				ItemFormView(
					name: $homeViewModel.addRoutineName,
					description: $homeViewModel.addRoutineDescription
				)
				
				Spacer()
			}
			.padding(20)
			.presentationDetents([.medium])
		}
		.task {
			homeViewModel.fetchData()
		}
	}
	
}

#Preview {
	let container = CaraApp.previewSharedContainer
	
	let homeViewModel = HomeViewModel(modelContext: container.mainContext)
	
	NavigationStack {
		HomeView()
			.environment(homeViewModel)
	}
}
