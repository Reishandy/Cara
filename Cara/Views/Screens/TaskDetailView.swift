//
//  TaskDetailView.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI
import SwiftData

struct TaskDetailView: View {
	@Environment(\.editMode) private var editMode
	@Environment(\.dismiss) private var dismiss
	@Environment(\.colorScheme) var colorScheme
	@Environment(TaskDetailViewModel.self) private var taskDetailViewModel
	
	@Bindable var task: RoutineTask
	
	@State private var showAppBarTitle = false
	@State private var showDeleteConfirmation = false
	
	private var isEdit: Bool {
		editMode?.wrappedValue == .active
	}
	
	var body: some View {
		ZStack(alignment: .top) {
			headerImage
			
			ScrollView {
				VStack(spacing: 0) {
					Spacer()
						.frame(height: 160)
					
					contentView
				}
			}
			.onScrollGeometryChange(for: CGFloat.self) { geometry in
				geometry.contentOffset.y
			} action: { oldOffset, newOffset in
				if newOffset > 100 {
					showAppBarTitle = true
				} else {
					showAppBarTitle = false
				}
			}
		}
		.ignoresSafeArea(edges: .top)
		.toolbar(.hidden, for: .tabBar)
		.toolbar {
			if isEdit {
				ToolbarItem(placement: .topBarTrailing) {
					
					Button {
						showDeleteConfirmation = true
					} label: {
						Image(systemName: "trash")
							.foregroundStyle(.red)
					}
					.confirmationDialog(
						"Delete",
						isPresented: $showDeleteConfirmation
					) {
						Button("Delete Task", role: .destructive) {
							dismiss()
							taskDetailViewModel.deleteTask(task: task)
						}
						.buttonStyle(.bordered)
					} message: {
						Text("This action will delete this task across all routines. Are you sure? this action cannot be undone.")
					}
				}
			}
			
			if !task.isDefault {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
			}
		}
		.task {
			taskDetailViewModel.fetchData()
		}
	}
	
	private var headerImage: some View {
		ZStack(alignment: .bottomLeading) {
			if let imageSystemName = task.imageSystemName {
				Image(imageSystemName)
					.resizable()
					.clipped()
			}
			
			if let image = UIImage(data: task.image ?? Data()) {
				Image(uiImage: image)
			}
			
			Color.gray
			
			LinearGradient(
				colors: [.clear, colorScheme == .dark ? .black : .white],
				startPoint: .center,
				endPoint: .bottom
			)
		}
		.frame(height: 280)
	}
	
	private var contentView: some View {
		VStack(alignment: .leading) {
			if !showAppBarTitle && !isEdit {
				Text(task.taskName)
					.font(.title2)
					.bold()
					.foregroundStyle(.white)
					.padding(.horizontal, 16)
					.padding(.bottom, 4)
					.shadow(color: .black.opacity(0.8), radius: 10, x: 0, y: 2)
			} else {
				Spacer().frame(height: 60)
			}
			
			VStack(alignment: .leading) {
				if isEdit {
					ItemFormView(
						isTask: true,
						name: $task.taskName,
						description: $task.taskDescription,
						categories: taskDetailViewModel.categories,
						category: $task.category
					)
					.padding(.bottom, 8)
				} else {
					Text(task.taskDescription)
						.font(.subheadline)
						.foregroundStyle(.appPrimary)
						.padding(.bottom, 8)
				}
				
				Text("Instruction")
					.font(isEdit ? .title2 : .title)
					.bold()
					.foregroundStyle(.appPrimary)
					.padding(.bottom, 8)
				
				if task.howTo.isEmpty && !isEdit {
					VStack(spacing: 8) {
						Text("No Instructions")
							.font(.title2)
							.bold()
							.foregroundStyle(.secondary)
							.fixedSize(horizontal: false, vertical: true)
						Text("No instructions are available for this task")
							.font(.subheadline)
							.foregroundStyle(.secondary)
							.fixedSize(horizontal: false, vertical: true)
					}
					.frame(maxWidth: .infinity)
					.padding(.top, 60)
				} else {
					ForEach(Array(task.howTo.enumerated()), id: \.offset) { index, _ in
						TaskInstructionView(
							number: index + 1,
							content: $task.howTo[index],
							isEdit: isEdit,
							onDeleteClick: {
								withAnimation {
									_ = task.howTo.remove(at: index)
								}
							}
						)
					}
					
					if isEdit {
						Button {
							withAnimation {
								task.howTo.append("")
							}
						} label: {
							HStack {
								Image(systemName: "plus")
								
								Text("Add a step")
							}
						}
						.padding()
						.foregroundStyle(.appPrimary)
						.overlay(
							RoundedRectangle(cornerRadius: 12)
								.strokeBorder(.appSecondary.opacity(0.8), lineWidth: 2)
						)
						.frame(maxWidth: .infinity)
					}
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(28)
			.background(Color.appBackground)
			.clipShape(
				UnevenRoundedRectangle(
					topLeadingRadius: 36,
					topTrailingRadius: 36
				)
			)
		}
	}
}

private struct TaskInstructionView: View {
	let number: Int
	@Binding var content: String
	let isEdit: Bool
	let onDeleteClick: () -> Void
	
	var body: some View {
		ZStack(alignment: .leading) {
			if isEdit {
				TextField("Input an instruction", text: $content, axis: .vertical)
					.padding()
					.padding(.horizontal, 20)
					.frame(maxWidth: .infinity, alignment: .leading)
					.background(Color.capsule)
					.foregroundStyle(.appPrimary)
					.clipShape(RoundedRectangle(cornerRadius: 12))
			} else {
				Text(content)
					.padding()
					.padding(.leading, 20)
					.frame(maxWidth: .infinity, alignment: .leading)
					.background(Color.capsule)
					.foregroundStyle(.appPrimary)
					.clipShape(RoundedRectangle(cornerRadius: 12))
			}
			
			HStack {
				Text("\(number)")
					.font(.title3)
					.bold()
					.foregroundStyle(Color.background)
					.padding()
					.background(.appSecondary)
					.clipShape(RoundedRectangle(cornerRadius: 12))
					.offset(x: -16)
				
				Spacer()
				
				if isEdit {
					Button {
						onDeleteClick()
					} label: {
						Image(systemName: "trash")
							.font(.title3)
					}
					.padding(.vertical)
					.padding(.horizontal, 10)
					.background(.red)
					.foregroundStyle(.white)
					.clipShape(RoundedRectangle(cornerRadius: 12))
					.offset(x: 16)
				}
			}
		}
	}
}

#Preview {
	let container = CaraApp.previewSharedContainer
	
	let taskDetailViewModel = TaskDetailViewModel(modelContext: container.mainContext)
	
	NavigationStack {
		TaskDetailView(task: RoutineTask.defaultData.first!)
			.environment(taskDetailViewModel)
	}
}
