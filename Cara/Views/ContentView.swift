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
	@AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
	@State private var selectedTab: Tab = .routine
	
	var body: some View {
		Group {
			if hasSeenOnboarding {
				TabView(selection: $selectedTab) {
					NavigationStack {
						HomeView()
					}
					.tag(Tab.routine)
					.tabItem {
						Image(systemName: "accessibility")
					}
					
					NavigationStack {
						LearnView()
					}
					.tag(Tab.learn)
					.tabItem {
						Image(systemName: "book.pages")
					}
				}
				.tint(.appSecondary)
				.scrollDismissesKeyboard(.interactively)
			} else {
				OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
			}
		}
		.animation(.easeInOut, value: hasSeenOnboarding)
	}
}

#Preview {
	let container = CaraApp.previewSharedContainer
	
	let homeViewModel = HomeViewModel(modelContext: container.mainContext)
	let learnViewModel = LearnViewModel(modelContext: container.mainContext)
	let routineDetailViewModel = RoutineDetailViewModel(modelContext: container.mainContext)
	let taskSelectViewModel = TaskSelectViewModel(modelContext: container.mainContext)
	let taskDetailViewModel = TaskDetailViewModel(modelContext: container.mainContext)
	
	ContentView()
		.environment(homeViewModel)
		.environment(learnViewModel)
		.environment(routineDetailViewModel)
		.environment(taskSelectViewModel)
		.environment(taskDetailViewModel)
}
