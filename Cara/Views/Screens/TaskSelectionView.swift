//
//  TaskSelectionView.swift
//  CH3-PM-Team4
//
//  Created by Kennard M on 29/05/26.
//

import SwiftUI

struct TaskSelectionView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    var taskCategory: String = "Task Category"
    var taskAmount: Int = 0
    @State private var searchTask = ""
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                ForEach (0..<10, id: \.self) { _ in
                    NavigationLink(
                        value: Screen.taskDetail
                    ) {
                        TaskCardView()
                    }
                }
            }
            .searchable(text: $searchTask, prompt: "Search Task...")
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                Button {
                    // FIXME: need to route this to action
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
    }
    
    @ViewBuilder
    private var selectedTaskButtonLabel: some View {
        if dynamicTypeSize.isAccessibilitySize {
            VStack(spacing: 2) {
                Text("\(taskAmount) Selected")
                Text("Save")
                    .font(.headline)
            }
            .multilineTextAlignment(.center)
        } else {
            Text("\(taskAmount) Selected • Save")
                .font(.headline)
        }
    }
}

#Preview {
    NavigationStack{
        TaskSelectionView()
    }
}
