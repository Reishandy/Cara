//
//  TaskCardView.swift
//  CH3-PM-Team4
//
//  Created by Kennard M on 29/05/26.
//

import SwiftUI

struct TaskCardView: View {
    @State var taskName: String = "Task Name"
    @State var taskDesc: String = "Task Description"
    @State var taskIconEach: String = "pill.circle.fill"
    @State var isChecked: Bool = false
    
    
    var body: some View {
        if !isChecked {
            HStack(spacing: 20){
                TaskIconView(taskIcon: taskIconEach)
                VStack (alignment: .leading){
                    Text(taskName)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color("AppPrimaryColor"))
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .frame(maxWidth: 170, maxHeight: .infinity, alignment: .leading)
                        
                }
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0)) {
                        isChecked.toggle()}
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 30))
                        .foregroundStyle(Color("AppThirdColor"))
                    
                }
                .buttonStyle(.plain)
                
            }
            .frame(maxWidth: .infinity,
                   minHeight: 30,
                   maxHeight: 50,
                   alignment: .leading)
            .padding()
            .background(Color("CapsuleColor"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)

        } else {
            HStack(spacing: 20){
                TaskIconView(taskIcon: taskIconEach)
                VStack (alignment: .leading){
                    Text(taskName)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color("AppPrimaryColor"))
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .frame(maxWidth: 170, maxHeight: .infinity, alignment: .leading)
                        
                }
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0)) {
                        isChecked.toggle()}
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color("AppThirdColor"))
                    
                }
                .buttonStyle(.plain)
                
            }
            .frame(maxWidth: .infinity,
                   minHeight: 30,
                   maxHeight: 50,
                   alignment: .leading)
            .padding()
            .background(Color("SelectedColor"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)

        }
                        
        
        
    }
}

#Preview {
    TaskCardView()
}
