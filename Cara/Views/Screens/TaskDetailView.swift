//
//  TaskDetailView.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI

struct TaskDetailView: View {
    @State private var showAppBarTitle = false
    
	let task: RoutineTask
    
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
		.navigationTitle(task.taskName)
		.toolbar(.hidden, for: .tabBar)
    }
    
	// FIXME: Actually use the image data
    let imageUrl = "https://www.seniorlivingarrangements.com/wp-content/uploads/2018/08/Senior-Care-Centre.jpg"
    
    private var headerImage: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .frame(height: 430)
                    .clipped()
            } placeholder: {
                Color.gray
            }
            
            LinearGradient(
                colors: [.clear, .black],
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
