//
//  TaskSelectionView.swift
//  CH3-PM-Team4
//
//  Created by Kennard M on 29/05/26.
//

import SwiftUI
import SwiftData

struct TaskSelectionView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(TaskSelectViewModel.self) private var taskSelectViewModel
	
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize
	
	var initialTasks: [RoutineTask]? = nil
	var onSaveAction: (([RoutineTask]) -> Void)? = nil
	
	var body: some View {
		@Bindable var taskSelectViewModel = taskSelectViewModel
		
		VStack {
			ScrollView(.vertical, showsIndicators: true) {
				ForEach(taskSelectViewModel.groupedTasks.keys.sorted(), id: \.self) { categoryName in
					Text(categoryName)
						.font(.title2)
						.bold()
						.foregroundStyle(.appPrimary)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.bottom, 4)
						.padding(.top, 10)
					
					ForEach(taskSelectViewModel.groupedTasks[categoryName] ?? [], id: \.id) { task in
						NavigationLink {
							TaskDetailView(task: task)
						} label: {
							TaskCardView(
								taskName: task.taskName,
								taskIconEach: task.taskIcon,
								style: self.taskSelectViewModel.selectedTasks.contains(task) ? .checked : .plus,
								onButtonClick: {
									if self.taskSelectViewModel.selectedTasks.contains(task) {
										self.taskSelectViewModel.selectedTasks.removeAll { $0.id == task.id }
									} else {
										self.taskSelectViewModel.selectedTasks.append(task)
									}
								}
							)
						}
					}
				}
			}
			.searchable(
				text: $taskSelectViewModel.searchTerm,
				placement: .navigationBarDrawer(displayMode: .always),
				prompt: "Search Task..."
			)
		}
		.toolbar{
			ToolbarItem(placement: .bottomBar) {
				Button {
					onSaveAction?(self.taskSelectViewModel.selectedTasks)
					self.taskSelectViewModel.selectedTasks = []
					dismiss()
				} label: {
					selectedTaskButtonLabel
				}
				.frame(maxWidth: .infinity)
				.buttonStyle(.borderedProminent)
				.tint(Color("AppThirdColor"))
			}
		}
		.navigationTitle("Add Tasks")
		.navigationBarTitleDisplayMode(.inline)
		.padding(.horizontal, 20)
		.task {
			self.taskSelectViewModel.fetchData()
			self.taskSelectViewModel.selectedTasks = initialTasks ?? []
		}
	}
	
	@ViewBuilder
	private var selectedTaskButtonLabel: some View {
		if dynamicTypeSize.isAccessibilitySize {
			VStack(spacing: 2) {
				Text("\(taskSelectViewModel.selectedTasks.count) Selected")
				Text("Save")
					.font(.headline)
			}
			.multilineTextAlignment(.center)
		} else {
			Text("\(taskSelectViewModel.selectedTasks.count) Selected • Save")
				.font(.headline)
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	let container = CaraApp.previewSharedContainer
	let taskSelectViewModel = TaskSelectViewModel(modelContext: container.mainContext)
	
	NavigationStack {
		TaskSelectionView()
			.environment(taskSelectViewModel)
	}
}
