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
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    Button("All") {
                        learnViewModel.categoryFilter = []
                    }
                    
                    ForEach(learnViewModel.categories, id: \.id) { category in
                        Button(category.categoryName) {
                            learnViewModel.categoryFilter = [category]
                        }
                    }
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }
                
            }
        }
        .navigationTitle("Learn")
		.toolbarTitleDisplayMode(.inlineLarge)
        .padding(.horizontal)
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
