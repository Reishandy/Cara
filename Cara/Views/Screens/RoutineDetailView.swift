//
//  RoutineDetailView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI

enum RoutineDetailElement {
    case task
    case note
}

struct RoutineDetailView: View {
    @Bindable var routine: Routine
    @State private var currentElement: RoutineDetailElement = .task
    
    
    @State private var noteText: String = ""
    @State private var lastEditedDate: Date? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            // FIXME: Filled indicator
            
            // FIXME: Day select color matching
            
            // FIXME: Change color and also font size
            Picker("Routine Detail Element", selection: $currentElement) {
                Text("Task")
                    .tag(RoutineDetailElement.task)
                
                Text("Note")
                    .tag(RoutineDetailElement.note)
            }
            .pickerStyle(.segmented)
            .padding(.top, 16)
            
            switch currentElement {
            case .task:
                // FIXME: Vitals color matching
                VStack(spacing: 24) {
                    HStack {
                        Text("Check Vitals")
                            .font(.title)
                            .bold()
                        
                        Image(systemName: "questionmark.circle")
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 24) {
                        HStack {
                            VitalPillView(
                                title: "Blood Pressure",
                                unit: " / 80 mmhg",
                                systemIcon: "thermometer.variable",
                                value: .constant("") // FIXME: Change this
                            )
                            
                            VitalPillView(
                                title: "Blood Pressure",
                                unit: " / 80 mmhg",
                                systemIcon: "thermometer.variable",
                                value: .constant("") // FIXME: Change this
                            )
                        }
                        
                        HStack {
                            VitalPillView(
                                title: "Blood Pressure",
                                unit: " / 80 mmhg",
                                systemIcon: "thermometer.variable",
                                value: .constant("") // FIXME: Change this
                            )
                            
                            VitalPillView(
                                title: "Blood Pressure",
                                unit: " / 80 mmhg",
                                systemIcon: "thermometer.variable",
                                value: .constant("") // FIXME: Change this
                            )
                        }
                    }
                }
                
                
                // FIXME: Tasks color matching
                VStack(spacing: 24) {
                    HStack {
                        Text("Tasks")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                    }
                }
            case .note:
                // FIXME: Note color matching
                Text("Notes")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.yellow.opacity(0.15))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TextEditor(text: $noteText)
                            .scrollContentBackground(.hidden)
                            .padding(16)
                            .onChange(of: noteText) {
                                lastEditedDate = Date()
                            }
                        if let date = lastEditedDate {
                            Text("Last edited: \(date.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .padding([.bottom, .leading], 16)
                        }
                    }
                    
                }
                .frame(maxHeight: .infinity)
                
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 2) {
                    TextField("Routine name", text: $routine.routineName)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(Date().formatted(date: .long, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        
                        
                }
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RoutineDetailView(
            routine: Routine(
            routineName: "Morning Routine",
            routineDescription: "Every Morning"
        )
            )
    }
}
