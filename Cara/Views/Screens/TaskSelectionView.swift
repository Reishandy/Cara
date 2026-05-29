//
//  TaskSelectionView.swift
//  CH3-PM-Team4
//
//  Created by Kennard M on 29/05/26.
//

import SwiftUI

struct TaskSelectionView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach (0..<10, id: \.self) { _ in
				NavigationLink(
					value: Screen.taskDetail
				) {
                    TaskCardView()
                }
            }
        }
    }
}

#Preview {
	TaskSelectionView()
}
