//
//  TaskSelectedView.swift
//  Cara
//
//  Created by Kennard M on 02/06/26.
//

import SwiftUI

struct TaskIconView: View {
    var taskIcon: String = "pill.circle.fill"

    var body: some View {
        ZStack{
            Circle()
                .fill(Color("AppPrimaryColor"))
                .frame(width: 60, height: 60)
            Image(systemName:taskIcon)
                .foregroundStyle(Color(.white))
                .font(.system(size: 30))
            
        }
    }
}

#Preview {
    TaskIconView()
}
