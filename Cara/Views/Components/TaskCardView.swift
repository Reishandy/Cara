//
//  TaskCardView.swift
//  CH3-PM-Team4
//
//  Created by Kennard M on 29/05/26.
//

import SwiftUI
struct TaskCardView: View {
    enum CardStyle {
        case plus
        case checked
        case uncheckedCircle
        case noButton
    }
    
    let taskName: String
    let taskDesc: String
    let taskIconEach: String
    let style: CardStyle
    let onButtonClick: (() -> Void)?
    let clickTime: Date?
    
    init(
        taskName: String = "Task Name",
        taskDesc: String = "Task Description",
        taskIconEach: String = "pill.circle.fill",
        style: CardStyle = .plus,
        onButtonClick: (() -> Void)? = nil,
        clickTime: Date? = nil
    ) {
        self.taskName = taskName
        self.taskDesc = taskDesc
        self.taskIconEach = taskIconEach
        self.style = style
        self.onButtonClick = onButtonClick
        self.clickTime = clickTime
    }
    var body: some View {
        HStack(spacing: 20){
            TaskIconView(taskIcon: taskIconEach)
            VStack (alignment: .leading){
                Text(taskName)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color("AppPrimaryColor"))
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .frame(maxWidth: 170, maxHeight: .infinity, alignment: .leading)
                if let clickTime = clickTime {
                    Text(clickTime.formatted(date: .omitted, time: .shortened))
                }
            }
            
            Spacer()
            
            if style != .noButton {
                Button {
                    onButtonClick?()
                } label: {
                    Image(systemName: buttonIconName)
                        .font(.system(size: 30))
                        .foregroundStyle(Color("AppThirdColor"))
                }
                .buttonStyle(.plain)
            }
            
        }
        .frame(maxWidth: .infinity,
               minHeight: 30,
               maxHeight: 50,
               alignment: .leading)
        .padding()
        .background(Color("CapsuleColor"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var backgroundColor: Color {
        style == .checked ? Color("SelectedColor") : Color("CapsuleColor")
    }
    
    private var buttonIconName: String {
        switch style {
        case .plus:            return "plus.circle"
        case .checked:         return "checkmark.circle.fill"
        case .uncheckedCircle: return "circle"
        case .noButton:        return ""
        }
    }
}


#Preview {
    TaskCardView(style: .plus)
    TaskCardView(style: .checked)
    TaskCardView(style: .uncheckedCircle)
    TaskCardView(style: .noButton)
}
