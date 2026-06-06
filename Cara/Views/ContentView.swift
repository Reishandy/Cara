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
	//	- Home crud routine
	//	- Routine edit
	// FIXME: TODO List
	//	- Task detail revamp (also fix back button and from other place)
	//	- Task Detail add and edit
	//	- Match padding sketch
	//	- Do tabview color and chek dark mode
	//	- Check large text accessability again
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
