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
    let selectedDay: Date
    
    @State private var currentElement: RoutineDetailElement = .task
    
    @State private var vitalFilledDate: Date? = nil
    @State private var bloodPressure: String = ""
    @State private var heartRate: String = ""
    @State private var temperature: String = ""
    @State private var oxygenLevel: String = ""
    
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
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 8) {
                                ZStack{
                                    Circle()
                                        .fill(Color("AppPrimaryColor"))
                                        .frame(width: 44, height: 44)
                                    Image(systemName:"waveform.path.ecg.text.clipboard.fill")
                                        .foregroundStyle(Color("BackgroundColor"))
                                        .font(.system(size: 22))
                                
                            }
                            Text("Vitals Check")
                                .foregroundStyle(Color("AppPrimaryColor"))
                                .font(.system(size: 17, weight: .medium, design: .default))
                        }
                        
                        
                        HStack(spacing: 8) {
                            VitalPillView(
                                unit: "mm HG",
                                systemIcon: "blood.pressure.cuff",
                                value: $bloodPressure
                                
                            ).onChange(of: bloodPressure) {
                                vitalFilledDate = Date()
                            }
                            
                            VitalPillView(
                                unit: "bpm",
                                systemIcon: "waveform.path.ecg",
                                value: $heartRate
                            ).onChange(of: heartRate) {
                                vitalFilledDate = Date()
                            }
                            
                            VitalPillView(
                                unit: "℃",
                                systemIcon: "thermometer.variable",
                                value: $temperature
                            ).onChange(of: temperature) {
                                vitalFilledDate = Date()
                            }
                            
                            VitalPillView(
                                
                                unit: " %",
                                systemIcon: "lungs",
                                value: $oxygenLevel
                            )
                            .onChange(of: oxygenLevel) {
                                vitalFilledDate = Date()
                            }
                        }
                        
                        if let date = vitalFilledDate {
                            HStack {
                                Image(systemName: "clock")
                                Text("Filled at \(date.formatted(date: .omitted, time: .shortened))")
                            }
                            .font(.caption)
                            .padding(5)
                            .foregroundStyle(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                
                
                // FIXME: Tasks color matching
                VStack(spacing: 24) {
                    
                    if routine.tasks.isEmpty {
                        VStack(spacing: 8) {
                            Text("No Tasks")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.secondary)
                            Text("Start by adding a task")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 90)
                        
                        //Else 추가
                        
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
                        .fill(Color.appThird.opacity(0.15))
                    
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
            
            ToolbarItem(placement: .bottomBar) {
                
                Button {
                    ///
                } label: {
                    Text("Add Task")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .tint(Color("AppThirdColor"))
            }
            
            ToolbarItem(placement: .principal) {
                VStack(spacing: 2) {
                    TextField("Routine name", text: $routine.routineName)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.appPrimary)
                    Text(selectedDay.formatted(date: .long, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(.appThird)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            UISegmentedControl.appearance().backgroundColor = UIColor.appThird.withAlphaComponent(0.15)
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.appThird
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.white],
                for: .selected
            )
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.appPrimary],
                for: .normal
                )
        }
    }
}

#Preview {
    NavigationStack {
        RoutineDetailView(
            routine: Routine(
            routineName: "Morning Routine",
            routineDescription: "Every Morning"
            ), selectedDay: .now
            )
    }
}
