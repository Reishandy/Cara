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
	@State private var currentElement: RoutineDetailElement = .task
	
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
				Text("")
			}
			
			Spacer()
		}
		.padding(.horizontal, 24)
		.navigationTitle("Morning Routine") // FIXME: Change to dynamic
		.navigationBarTitleDisplayMode(.inline) // FIXME: Change to
	}
}

#Preview {
	NavigationStack {
		RoutineDetailView()
	}
}
