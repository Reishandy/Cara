//
//  TaskSelectionReviewPage.swift
//  Cara
//
//  Created by Kennard M on 03/06/26.
//

import SwiftUI

struct TaskSelectionReviewPage: View {
    var placeholder: String = "Example: Morning Routine"
    @State var routineInput: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            VStack{
                TaskCategoryView(taskCategory: "Routine Name")
                
                TextField(placeholder, text: $routineInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(size: 17, weight: .regular))
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
                    
                    // ADD NEW EXERCISE BUTTON
                    Button() {
                        // FIXME: need to route this to action
                    } label: {
                        HStack(){
                            Image(systemName: "plus")
                            Text("Add More Task")
                                .font(.system(size:17))
                        }
                        .foregroundStyle(Color("AppThirdColor"))
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("AppThirdColor"), lineWidth: 1)
                        )
                    }
                    .padding(.bottom, 50)
                    
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                Button {
                    // FIXME: need to route this to action
                } label: {
                    Text("Save Routine")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .tint(Color("AppPrimaryColor"))
            }
        }
        .padding()
    }
}

#Preview {
    TaskSelectionReviewPage()
}
