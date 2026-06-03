//
//  ContentView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 25/05/26.
//

import SwiftUI

enum Tab {
	case routine
	case learn
}

struct ContentView: View {
	@State private var router = NavigationRouter()
	@State private var selectedTab: Tab = .routine
	
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
				case .routineAdd:
					Text("This is routine add")
                case .routineDetail(let routine, let day):
					RoutineDetailView(routine: routine, selectedDay: day)
				case .taskDetail:
					Text("This is task detail")
				case .taskAdd:
					Text("This is task add")
				}
			}
		}
		.environment(router)
	}
}

#Preview {
	ContentView()
}
