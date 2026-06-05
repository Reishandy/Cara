//
//  TaskSelectedView.swift
//  Cara
//
//  Created by Kennard M on 02/06/26.
//

import SwiftUI

struct TaskIconView: View {
    @ScaledMetric(relativeTo: .body) private var circleSize = 44
    @ScaledMetric(relativeTo: .body) private var iconSize = 26
    
    var taskIcon: String = "pill.circle.fill"

    var body: some View {
        ZStack{
            Circle()
                .fill(Color("AppPrimaryColor"))
                .frame(width: circleSize, height: circleSize)
            Image(systemName:taskIcon)
                .foregroundStyle(Color("BackgroundColor"))
                .font(.system(size: iconSize))
        }
    }
}

#Preview {
    TaskIconView()
}
