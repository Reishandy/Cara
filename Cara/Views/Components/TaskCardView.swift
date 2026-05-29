//
//  TaskCardView.swift
//  CH3-PM-Team4
//
//  Created by Kennard M on 29/05/26.
//

import SwiftUI

struct TaskCardView: View {
    @State var taskIcon: String = "pill.circle.fill"
    @State var taskName: String = "Task Name"
    @State var taskDesc: String = "Task Description"
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("CapsuleColor"))
                    .frame(maxWidth: .infinity, maxHeight: 100)
                HStack(spacing: 20){
                    ZStack{
                        Circle()
                            .fill(Color("AppPrimaryColor"))
                            .frame(width: 60, height: 60)
                        Image(systemName:taskIcon)
                            .foregroundStyle(Color(.white))
                            .font(.system(size: 30))
                        
                    }
                    VStack (alignment: .leading){
                        Text(taskName)
                            .foregroundStyle(Color("AppPrimaryColor"))
                            .font(.system(size: 20, weight: .bold, design: .default))
                        Text(taskDesc)
                            .foregroundStyle(Color("AppThirdColor"))
                            .font(.system(size: 15, weight: .regular))
                    }
                    
                    Spacer()
                    
                    Button {
                        // nanti buat masukin ke list
                    } label: {
                            Image(systemName: "plus.circle")
                            .font(.system(size: 50))
                            .foregroundStyle(Color("AppThirdColor"))
                            
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            .buttonStyle(.bordered)
            .tint(Color("AppThirdColor"))
    }
}

#Preview {
    TaskCardView()
}
