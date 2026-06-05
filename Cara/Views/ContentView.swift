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
	@State private var router = NavigationRouter()
	@State private var selectedTab: Tab = .routine
	
	// FIXME: TODO List
	//	- Routine detail and interactivity (routine desc)
	//	- Search and filter for tasks
	//	- Task detail (also fix back button and from other place)
	//	- Home crud routine
	//	- Routine edit
	//	- Task Detail edit
	//	- Toolbar in contentview
	//	- Match padding sketch
	//	- Do tabview color and chek dark mode
	//	- Check large text accessability again
	//	- Animation
	
	var body: some View {
		NavigationStack(path: $router.path) {
			TabView(selection: $selectedTab) {
				HomeView()
					.tag(Tab.routine)
					.tabItem {
						VStack {
							Image(systemName: "accessibility")
							Text("Routine")
						}
					}
				
				TaskSelectionView()
					.tag(Tab.learn)
					.tabItem {
						VStack {
							Image(systemName: "book.pages")
							Text("Learn")
						}
					}
			}
			.navigationDestination(for: Screen.self) { screen in
				// FIXME: Change this to proper view
				switch screen {
				case .home:
					HomeView()
				case .learn:
					TaskSelectionView()
                case .routineDetail(let routine, let day):
					RoutineDetailView(routine: routine, selectedDay: day)
				case .taskSelection:
					Text("This is task selection for add")
				case .taskDetail(let task):
					TaskDetailView(task: task)
				}
			}
		}
		.environment(router)
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
