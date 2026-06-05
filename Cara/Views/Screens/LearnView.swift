//
//  LearnView.swift
//  Cara
//
//  Created by Kennard M on 04/06/26.
//

import SwiftUI
import SwiftData

struct LearnView: View {
    @Environment(LearnViewModel.self) private var learnViewModel
    
    let customColor = UIColor(named: "AppPrimaryColor") ?? .systemBlue
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: customColor]
    }
    
    var body: some View {
        @Bindable var learnViewModel = learnViewModel
        
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
				ForEach(learnViewModel.groupedTasks.keys.sorted(), id: \.self) { categoryName in
					Text(categoryName)
						.font(.title2)
						.bold()
						.foregroundStyle(.appPrimary)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.bottom, 4)
						.padding(.top, 10)
					
                    ForEach(learnViewModel.groupedTasks[categoryName] ?? [], id: \.id) { task in
						NavigationLink {
							TaskDetailView(task: task)
						} label: {
                            TaskCardView(
                                taskName: task.taskName,
                                taskIconEach: task.taskIcon,
                                style: .noButton
                            )
                        }
                    }
                }
            }
            .searchable(
                text: $learnViewModel.searchTerm,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search Task..."
            )
        }
        .toolbar{
			ToolbarItem(placement: .topBarTrailing) {
				Menu {
					Section("Categories") {
						Button {
							learnViewModel.categoryFilter = []
						} label: {
							if learnViewModel.categoryFilter.isEmpty {
								Label("All", systemImage: "checkmark")
							} else {
								Text("All")
							}
						}
						
						ForEach(learnViewModel.categories, id: \.id) { category in
							let isSelected = learnViewModel.categoryFilter.contains(where: { $0.id == category.id })
							
							Button {
								if isSelected {
									learnViewModel.categoryFilter.removeAll { $0.id == category.id }
								} else {
									learnViewModel.categoryFilter.append(category)
								}
							} label: {
								if isSelected {
									Label(category.categoryName, systemImage: "checkmark")
								} else {
									Text(category.categoryName)
								}
							}
						}
					}
				} label: {
					Label("Filter", systemImage: "line.3.horizontal.decrease")
				}
			}
        }
        .navigationTitle("Learn")
		.toolbarTitleDisplayMode(.inlineLarge)
        .padding(.horizontal, 20)
        .task {
            learnViewModel.fetchData()
        }
    }
}

#Preview {
    let container = CaraApp.previewSharedContainer
    let learnViewModel = LearnViewModel(modelContext: container.mainContext)

    NavigationStack {
        LearnView()
            .environment(learnViewModel)
    }
}
