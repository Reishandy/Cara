//
//  HomeView.swift
//  CH3-PM-Team4
//
//  Created by Fadil Himawan on 29/05/26.
//

import SwiftUI

struct HomeView: View {
    @State private var morningRoutine =
    Routine(routineName: "Morning Routine",
    routineDescription: "Every Morning")
    
    var body: some View {
		ScrollView {
			HStack {
				Text("26 May 2026")
				Spacer()
				Image(systemName: "chevron.down")
			}
			.padding(16)
			.background(Color.background)
			.cornerRadius(26)
			.foregroundStyle(.appPrimary)
			
			Text("Daily Routine")
				.font(.title)
				.foregroundStyle(.appPrimary)
			
			// FIXME: Change this to a component and ForEach
			NavigationLink(
                value: Screen.routineDetail(morningRoutine)
			) {
				VStack(alignment: .leading) {
					HStack() {
						CircularProgressRing(progress: 0.50)
						
						Spacer().frame(width: 24)
						
						VStack(alignment: .leading) {
							Text("Morning Routine")
							Text("Best time: 05:00 - 11:59")
							
							HStack {
								Circle()
									.foregroundStyle(.appThird)
									.frame(width: 16)
								
								Circle()
									.foregroundStyle(.appThird)
									.frame(width: 16)
							}
						}
						
						HStack {
							
						}
					}
					
					VStack {
						
					}
					
					Spacer().frame(height: 8)
					
					HStack {
						Image(systemName: "text.pad.header")
						Spacer()
							.frame(width: 6)
						Text("Mom is not happy")
					}
					.foregroundStyle(.appThird)
				}
				.frame(maxWidth: .infinity)
				.padding(20)
				.background(Color.secondaryBackground)
				.cornerRadius(13)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(16)
		// .navigationTitle("Caregiving")
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Text("Caregiving")
					.foregroundStyle(Color.primary)
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				Button {
					// do nothing
				} label: {
					Image(systemName: "plus")
				}
			}
		}
	}
	
}

#Preview {
	HomeView()
}

// FIXME: Move to components
struct CircularProgressRing: View {
	let progress: Double // 0.0 to 1.0
	
	var body: some View {
		ZStack {
			// inactive part
			Circle()
				.stroke(
					Color.gray.opacity(0.25),
					lineWidth: 12
				)
			
			// active part
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
		}
		.frame(width: 55, height: 55)
	}
}
