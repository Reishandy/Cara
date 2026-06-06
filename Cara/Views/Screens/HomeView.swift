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
	
	private var formattedDateString: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MMM yyyy"
		return formatter.string(from: homeViewModel.selectedDay)
	}
	
	// FIXME: Consider changing to toolbar for the caregiver and add button?
	// FIXME: Currently we can delete any routine soo...
	//			^ thankfully the action is hidden, maybe a confirmation dialog is good?
	var body: some View {
		ZStack(alignment: .top) {
			List {
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
				}
				.listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 12, trailing: 20))
				.listRowSeparator(.hidden)
				.listRowBackground(Color.clear)
				
				
				ForEach(homeViewModel.routines, id: \.self) { routine in
					if let history = homeViewModel.historiesDict[routine.id] {
						ZStack {
							NavigationLink {
								RoutineDetailView(routine: routine, selectedDay: homeViewModel.selectedDay)
							} label: {
								EmptyView()
							}
							.opacity(0)
							
							RoutineCard(
								routine: routine,
								history: history
							)
							.id("\(routine.id)-\(homeViewModel.fetchCounter)")
							// Using this to force the component to update it's reference
						}
					}
				}
				.onDelete(perform: homeViewModel.removeRoutine)
				.listRowSeparator(.hidden)
				.listRowInsets(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
			}
			.listStyle(.plain)
			.padding(.top, 70)
			
			HomeHeaderView()
				.padding(.horizontal, 20)
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.task {
			homeViewModel.fetchData()
		}
	}
	
}

struct HomeHeaderView: View {
	@ScaledMetric(relativeTo: .body) private var buttonSize = 48
	@ScaledMetric(relativeTo: .body) private var iconSize = 24
	
	var body: some View {
		HStack(alignment: .center) {
			Text("Caregiving")
				.font(.largeTitle)
				.bold()
				.foregroundStyle(.appPrimary)
				.fixedSize(horizontal: false, vertical: true)
			
			Spacer(minLength: 12)
			
			Button {
				// FIXME: Open add sheet
			} label: {
				Image(systemName: "plus")
					.font(.system(size: iconSize, weight: .regular))
					.foregroundStyle(.appPrimary)
					.frame(width: buttonSize, height: buttonSize)
					.background(Color.background)
					.clipShape(Circle())
			}
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
