//
//  LearnView.swift
//  Cara
//
//  Created by Kennard M on 04/06/26.
//

import SwiftUI

struct LearnView: View {
    var taskCategory: String = "Task Category"
    var taskAmount: Int = 0
    @State private var searchTask = ""
    let customColor = UIColor(named: "AppPrimaryColor") ?? .systemBlue
    
    init() {
      UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: customColor]
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                ForEach (0..<10, id: \.self) { _ in
                    NavigationLink(
                        value: Screen.taskDetail
                    ) {
                        TaskCardView(style: .noButton)
                    }
                }
            }
            .searchable(text: $searchTask,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search Task...")
        }
        
        .navigationTitle("Learn")
        .navigationSubtitle("Click on a task to learn more")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack{
        LearnView()
    }
}
