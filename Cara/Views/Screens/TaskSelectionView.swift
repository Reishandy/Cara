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
	var isEdit: Bool = false
	
	@State private var hasInitialized: Bool = false
	@State private var showAddTaskSheet = false
	
	var body: some View {
		@Bindable var taskSelectViewModel = taskSelectViewModel
		
		TaskListView(groupedTasks: taskSelectViewModel.groupedTasks) { task in
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
		.searchable(
			text: $taskSelectViewModel.searchTerm,
			placement: .navigationBarDrawer(displayMode: .always),
			prompt: "Search Task..."
		)
		.toolbar{
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					showAddTaskSheet = true
				} label: {
					Image(systemName: "plus")
				}
			}
		}
		.safeAreaInset(edge: .bottom, spacing: 0) {
			VStack(spacing: 0) {
				Button {
					onSaveAction?(self.taskSelectViewModel.selectedTasks)
					self.taskSelectViewModel.selectedTasks = []
					dismiss()
				} label: {
					selectedTaskButtonLabel
						.frame(maxWidth: .infinity)
						.padding(.vertical, 14)
				}
				.background(Color("AppThirdColor"))
				.clipShape(RoundedRectangle(cornerRadius: 18))
				.padding(.horizontal, 20)
				.padding(.top, 24)
			}
			.background {
				LinearGradient(
					colors: [
						Color.clear,
						Color.white.opacity(0.85),
						Color.white
					],
					startPoint: .top,
					endPoint: .bottom
				)
				.ignoresSafeArea(edges: .bottom)
			}
		}
		.navigationTitle(isEdit ? "Modify Tasks" : "Add Tasks")
		.navigationBarTitleDisplayMode(.inline)
		.sheet(isPresented: $showAddTaskSheet) {
			VStack {
				HStack {
					Button {
						showAddTaskSheet = false
					} label: {
						Text("Cancel")
							.font(.title3)
							.frame(width: 80)
					}
					.buttonStyle(.glass)
					
					Spacer()
					
					Button {
						showAddTaskSheet = false
						taskSelectViewModel.addTask()
					} label: {
						Text("Save")
							.font(.title3)
							.frame(width: 80)
					}
					.buttonStyle(.glassProminent)
					.disabled(taskSelectViewModel.addTaskName.isEmpty || taskSelectViewModel.addTaskDescription.isEmpty)
				}
				
				ItemFormView(
					isTask: true,
					name: $taskSelectViewModel.addTaskName,
					description: $taskSelectViewModel.addTaskDescription,
					categories: taskSelectViewModel.categories,
					category: $taskSelectViewModel.addTaskCategory,
					icon: $taskSelectViewModel.addTaskIcon
				)
				
				Spacer()
			}
			.padding(20)
			.presentationDetents([.height(520)])
		}
		.task {
			self.taskSelectViewModel.fetchData()
			
			if !hasInitialized {
				self.taskSelectViewModel.selectedTasks = initialTasks ?? []
				hasInitialized = true
			}
		}
	}
	
	@ViewBuilder
	private var selectedTaskButtonLabel: some View {
		if dynamicTypeSize.isAccessibilitySize {
			VStack(spacing: 2) {
				Text("\(taskSelectViewModel.selectedTasks.count) Selected")
					.foregroundStyle(.white)
				Text("Save")
					.font(.headline)
					.foregroundStyle(.white)
			}
			.multilineTextAlignment(.center)
		} else {
			Text("\(taskSelectViewModel.selectedTasks.count) Selected • Save")
				.font(.headline)
				.multilineTextAlignment(.center)
				.foregroundStyle(.white)
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
