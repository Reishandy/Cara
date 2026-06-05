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
                .fill(Color("AppSecondaryColor"))
                .frame(width: 44, height: 44)
            Image(systemName:taskIcon)
                .foregroundStyle(Color("BackgroundColor"))
                .font(.system(size: 26))
        }
    }
}

#Preview {
    TaskIconView()
}
