//
//  TaskRoutineDetailView.swift
//  Cara
//
//  Created by Kennard M on 02/06/26.
//

import SwiftUI
enum TaskRoutineDetailViewType {
    case check
    case edit
}


struct TaskRoutineDetailView: View {
    let type: TaskRoutineDetailViewType
    @State private var taskRoutineDetailTitle: String = "Task Name"
    @State private var taskRoutineDetailField: String = ""
    @State private var isOn: Bool = false
    
    var body: some View {
        switch type {
        case .check:
                HStack{
                    Text(taskRoutineDetailTitle)
                    Image(systemName: "questionmark.circle")
                    
                    Spacer()
                    
                    Toggle(isOn: $isOn) {
                    }
                    .toggleStyle(iOSCheckboxToggleStyle())

                }
                .padding() // inside padding
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(Color("CapsuleColor"))
                .foregroundStyle(Color("AppPrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding() // outside padding
            
           
            
        case .edit:

                HStack(spacing: 5){
                        TextField(text: $taskRoutineDetailField, prompt: Text(".....")) {
                            Text("Details")
                    }
                        .frame(width: 150)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(TextAlignment.center)
                    
                    Spacer()
                    
                    Text(taskRoutineDetailTitle)
                    Image(systemName: "questionmark.circle")
                    
                }
                .padding() // inside padding
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(Color("CapsuleColor"))
                .foregroundStyle(Color("AppPrimaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding() // outside padding
            
        }
        
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24))
            }
        })
    }
}

#Preview("Check Mode") {
    TaskRoutineDetailView(type: .check)
}

#Preview("Edit Mode") {
    TaskRoutineDetailView(type: .edit)
}
