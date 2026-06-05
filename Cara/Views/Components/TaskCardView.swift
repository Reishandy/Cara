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
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ScaledMetric(relativeTo: .body) private var buttonIconSize = 30
    
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
        Group {
            if dynamicTypeSize.isAccessibilitySize {
                accessibilityLayout
            } else {
                regularLayout
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var regularLayout: some View {
        HStack(alignment: .center, spacing: 20) {
            TaskIconView(taskIcon: taskIconEach)
            taskContent
            Spacer(minLength: 12)
            buttonView
        }
    }
    
    private var accessibilityLayout: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                TaskIconView(taskIcon: taskIconEach)
                taskContent
            }
            
            if style != .noButton {
                buttonView
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    private var taskContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(taskName)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color("AppPrimaryColor"))
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let clickTime = clickTime {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "clock")
                    Text(clickTime.formatted(date: .omitted, time: .shortened))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .font(.subheadline)
                .foregroundStyle(Color("AppPrimaryColor").opacity(0.7))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var buttonView: some View {
        if style != .noButton {
            Button {
                onButtonClick?()
            } label: {
                Image(systemName: buttonIconName)
                    .font(.system(size: buttonIconSize))
                    .foregroundStyle(Color("AppThirdColor"))
            }
            .buttonStyle(.plain)
        }
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

#Preview("Accessibility Text Scale") {
    VStack {
        TaskCardView(
            taskName: "Scheduled Medication with a longer task name",
            style: .plus
        )
        TaskCardView(
            taskName: "Assisted Hip & Knee Flexion",
            style: .checked,
            clickTime: .now
        )
        TaskCardView(
            taskName: "Tongue In-and-Outs",
            style: .noButton
        )
    }
    .padding()
    .environment(\.dynamicTypeSize, .accessibility3)
}
