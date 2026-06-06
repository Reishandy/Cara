//
//  TaskDetailView.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI

struct TaskDetailView: View {
	@Environment(\.colorScheme) var colorScheme
	
    @State private var showAppBarTitle = false
    
	let task: RoutineTask
    
	// FIXME: Check this again, the layour and stuff
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
            if !showAppBarTitle {
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
				Text(task.taskDescription)
                .font(.subheadline)
                .foregroundStyle(.appPrimary)
                .padding(.bottom, 8)
                
                Text("Instruction")
                    .font(.title.bold())
                    .foregroundStyle(.appPrimary)
                    .padding(.bottom, 8)
                
				ForEach(Array(task.howTo.enumerated()), id: \.offset) { index, step in
                    TaskInstructionView(
                        number: index + 1,
                        content: step
                    )
                }
            }
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
    let content: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(content)
                .padding()
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.capsule)
                .foregroundStyle(.appPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text("\(number)")
                .font(.title3)
                .bold()
                .foregroundStyle(Color.background)
                .padding()
                .background(.appSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .offset(x: -16)
        }
        
        Spacer().frame(height: 12)
    }
}

#Preview {
	TaskDetailView(task: RoutineTask.defaultData.first!)
}
