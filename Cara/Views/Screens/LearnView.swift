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
    @State private var selectedFilter: String = "All"
    
    init() {
      UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: customColor]
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                ForEach (0..<10, id: \.self) { _ in
					// FIXME: TODO
					
//                    NavigationLink(
//                        value: Screen.taskDetail
//                    ) {
                        TaskCardView(style: .noButton)
//                    }
                }
            }
            .searchable(text: $searchTask,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search Task...")
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    Button("All"){ selectedFilter = "All"}
                    Button("Physical Rehab"){ selectedFilter = "physicalRehab"}
                    Button("Swallowing & Oral Exercises (Dysphagia Safe)"){ selectedFilter = "swallowingExercise"}
                    Button("Daily Care Essentials & Activities of Daily Living (ADLs)"){ selectedFilter = "dailyCareEssentials"}
                    Button("Mobility Support & Safe Transfers"){ selectedFilter = "mobilitySupport"}
                    Button("Skin Integrity"){ selectedFilter = "skinIntegrity"}
                    Button("Nasogastric Tube (NGT) Management & Feeding"){ selectedFilter = "NGTManagement"}
                    Button("Advanced Tracheostomy Support & Airway Clearing"){ selectedFilter = "tracheostomySupport"}
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }
                
            }
        }
        
        .navigationTitle("Learn")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack{
        LearnView()
    }
}
