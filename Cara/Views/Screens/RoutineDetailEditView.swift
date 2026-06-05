//
//  TaskSelectionReviewPage.swift
//  Cara
//
//  Created by Kennard M on 03/06/26.
//

import SwiftUI

struct RoutineDetailEditView: View {
    var placeholder: String = "Example: Morning Routine"
    @State var routineInput: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            VStack{
                TaskCategoryView(taskCategory: "Routine Name")
                
                TextField(placeholder, text: $routineInput)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 50, style: .continuous)
                            .fill(Color("AppThirdColor").opacity(0.16))
                    )
            }
            
            VStack{
                TaskCategoryView(taskCategory: "Task")
                
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach (0..<10, id: \.self) { _ in
                        NavigationLink(
                            value: Screen.taskDetail
                        ) {
                            TaskCardView(style: .noButton)
                        }
                    }
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                Button {
                    // FIXME: need to route this to action
                } label: {
                    Text("Add Task")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .tint(Color("AppThirdColor"))
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Text("Save")
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
	NavigationStack{
		RoutineDetailEditView()
	}
}
