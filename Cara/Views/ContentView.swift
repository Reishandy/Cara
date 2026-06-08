//
//  ContentView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 25/05/26.
//

import SwiftUI
import SwiftData

enum Tab {
	case routine
	case learn
}

struct ContentView: View {
	@State private var selectedTab: Tab = .routine
	
	// FIXME: TODO List
	//	- Category add and edit?
	//	- Check large text accessability again
	//	- Make sure every scrollbar is at the edge of the screen (check learn, task select, routine detail, home)
	//	- Animation
	
	var body: some View {
		TabView(selection: $selectedTab) {
			NavigationStack {
				HomeView()
			}
			.tag(Tab.routine)
			.tabItem {
				VStack {
					Image(systemName: "accessibility")
					Text("Routine")
				}
			}
			
			NavigationStack {
				LearnView()
			}
			.tag(Tab.learn)
			.tabItem {
				VStack {
					Image(systemName: "book.pages")
					Text("Learn")
				}
			}
		}
		.tint(.appSecondary)
		.scrollDismissesKeyboard(.interactively)
	}
}

#Preview {
	let container = CaraApp.previewSharedContainer
	
	let homeViewModel = HomeViewModel(modelContext: container.mainContext)
	let learnViewModel = LearnViewModel(modelContext: container.mainContext)
	let routineDetailViewModel = RoutineDetailViewModel(modelContext: container.mainContext)
	let taskSelectViewModel = TaskSelectViewModel(modelContext: container.mainContext)
	
	ContentView()
		.environment(homeViewModel)
		.environment(learnViewModel)
		.environment(routineDetailViewModel)
		.environment(taskSelectViewModel)
}
