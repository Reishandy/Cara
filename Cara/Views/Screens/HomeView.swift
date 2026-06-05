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
        VStack(alignment: .leading, spacing: 16) {
            HomeHeaderView()
            
            ScrollView {
                // FIXME: Consider putting it in a menu
                Button {
                    showDatePicker = true
                } label: {
                    HStack {
                        Text(formattedDateString)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .imageScale(.medium)
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
                
                ForEach(homeViewModel.routines, id: \.self) { routine in
                    if let history = homeViewModel.historiesDict[routine.id] {
                        RoutineCard(routine: routine, history: history)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.top, 12)
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
                .foregroundStyle(.appSecondary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 12)
            
            NavigationLink(
                value: Screen.routineAdd
            ) {
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
