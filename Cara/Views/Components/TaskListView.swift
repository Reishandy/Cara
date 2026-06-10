//
//  TaskListView.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 10/06/26.
//

import SwiftUI

struct TaskListView<Content: View>: View {
	var groupedTasks: [String: [RoutineTask]] = [:]
	@ViewBuilder let content: (_ task: RoutineTask) -> Content
	
    var body: some View {
		ScrollView {
			ForEach(groupedTasks.keys.sorted(), id: \.self) { categoryName in
				Text(categoryName)
					.font(.title2)
					.bold()
					.foregroundStyle(.appPrimary)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.bottom, 4)
					.padding(.top, 10)
					.transition(.scale(0.8).combined(with: .opacity))
				
				ForEach(groupedTasks[categoryName] ?? [], id: \.id) { task in
					NavigationLink {
						TaskDetailView(task: task)
					} label: {
						content(task)
							.transition(.scale(0.8).combined(with: .opacity))
					}
				}
				.animation(.spring, value: groupedTasks[categoryName])
			}
			.padding(.horizontal, 20)
		}
		.animation(.spring, value: groupedTasks)
    }
}

#Preview {
	TaskListView() { _ in }
}
