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
        return formatter.string(from: homeViewModel.routineDay)
    }
    
    var body: some View {
        VStack {
            HomeHeaderView {
                // FIXME: Navigate to Add Routine
            }
            
            ScrollView {
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
                                homeViewModel.changeSelectedDay(date: $0)
                            }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                    
                }
                
                
                ForEach(homeViewModel.routines, id: \.self) { routine in
                    if let history = homeViewModel.historiesDict[routine.id] {
                        
                        Button {
                            // FIXME: Navigate to Routine Detail
                        } label: {
                            RoutineCard(routine: routine, history: history)
                        }
                    }
                }
                
            }
        }
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
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
        taskProgress: TaskProgress(status: [:]),
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

struct HomeHeaderView: View {
    var onAddTapped: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Caregiving")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.appPrimary)
            
            Spacer()
            
            Button(action: onAddTapped) {
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
