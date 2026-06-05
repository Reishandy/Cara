//
//  TaskDetailView.swift
//  Cara
//
//  Created by Fadil Himawan on 03/06/26.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showAppBarTitle = false
    
    private let steps = [
        "Hold the patient's weak forearm just above the wrist with one hand to keep it steady.",
        "Open your other hand and interlace your fingers with the patient's fingers, flattening their hand against yours.",
        "Slowly pull their fingers back to open the hand, and gently pull the entire hand backward at the wrist joint.",
        "Hold this open, stretched position for 15 to 30 seconds.",
        "Slowly release the stretch; never let the hand snap back rapidly.",
        "Hold the patient's weak forearm just above the wrist with one hand to keep it steady.",
        "Open your other hand and interlace your fingers with the patient's fingers, flattening their hand against yours.",
        "Hold the patient's weak forearm just above the wrist with one hand to keep it steady.",
        "Open your other hand and interlace your fingers with the patient's fingers, flattening their hand against yours."
    ]
    
    private let subtitle: String = """
                Opens the wrist and fingers to counteract "flexor spasticity" \
                (the natural tendency for a stroke-affected hand to curl into a tight fist).
                """
    private let title = "Wrist & Finger Stretch\n(Passive ROM)"
    
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
//                currentOffset = newOffset
                if newOffset > 100 {
                    showAppBarTitle = true
                } else {
                    showAppBarTitle = false
                }
            }
            
//            closeButton
        }
        .ignoresSafeArea(edges: .top)
        .navigationTitle(title)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            }
        }
    }
    
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
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 4)
            } else {
                Spacer().frame(height: 60)
            }
            
            VStack(alignment: .leading) {
                Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.appPrimary)
                .padding(.bottom, 8)
                
                Text("Instruction")
                    .font(.title.bold())
                    .foregroundStyle(.appPrimary)
                    .padding(.bottom, 8)
                
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
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
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 26, weight: .medium))
                .foregroundStyle(.black)
                .frame(width: 64, height: 64)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 64)
        .padding(.leading, 28)
    }
}

#Preview {
    TaskDetailView()
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
