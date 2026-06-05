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
    
    var body: some View {
		ZStack(alignment: .top) {
            ScrollView {
				VStack(alignment: .leading) {
					Button {
						showDatePicker = true
					} label: {
						HStack {
							Text(formattedDateString)
							Spacer()
							Image(systemName: "chevron.down")
						}
						.padding(16)
						.background(.secondaryBackground)
						.cornerRadius(26)
						.foregroundStyle(.appPrimary)
						
					}
					.sheet(isPresented: $showDatePicker) {
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
						.presentationDetents([.medium])
						.presentationDragIndicator(.visible)
					}
					
					Text("Routines")
						.font(.title)
						.bold()
						.foregroundStyle(.appPrimary)
					
					ForEach(homeViewModel.routines, id: \.self) { routine in
						if let history = homeViewModel.historiesDict[routine.id] {
							RoutineCard(routine: routine, history: history, selectedDay: homeViewModel.selectedDay)
						}
					}
				}
				.padding(.horizontal, 20)
            }
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
    var body: some View {
        HStack(alignment: .center) {
            Text("Caregiving")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.appSecondary)
            
            Spacer()
            
            NavigationLink(
                value: Screen.routineAdd
            ) {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(.appPrimary)
                    .frame(width: 48, height: 48)
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
