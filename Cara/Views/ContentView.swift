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
	//	- Routine detail and interactivity (routine desc)
	//	- Search and filter for tasks
	//	- Task detail revamp (also fix back button and from other place)
	//	- Home crud routine
	//	- Routine edit
	//	- Task Detail edit
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
	
	ContentView()
		.environment(homeViewModel)
		.environment(learnViewModel)
		.environment(routineDetailViewModel)
}
