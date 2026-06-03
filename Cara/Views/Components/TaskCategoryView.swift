//
//  TaskCategoryView.swift
//  Cara
//
//  Created by Kennard M on 03/06/26.
//

import SwiftUI

struct TaskCategoryView: View {
    @State var taskCategory: String = "Task Category"
    
    var body: some View {
        HStack {
            Text(taskCategory)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundStyle(Color("AppPrimaryColor"))
            Spacer()
        }
        .frame(alignment: .leading)
        .padding()
    }
}

#Preview {
    TaskCategoryView()
}
