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
            value: Screen.routineDetail
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

// FIXME: Move to components
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
