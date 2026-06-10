//
//  VitalPillView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI

struct VitalPillView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    @ScaledMetric(relativeTo: .body) private var spacing = 10
    @ScaledMetric(relativeTo: .body) private var padding = 12
    
    let name: String
    let unit: String
    let systemIcon: String
    var isBp: Bool = false
    
    @FocusState private var isCardFocused: Bool
    
    private var keyboardtype: UIKeyboardType {
        isBp ? .numbersAndPunctuation : .decimalPad
    }
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .center, spacing: spacing) {
            Image(systemName: systemIcon)
                .font(.title2)
                .foregroundStyle(.appPrimary)
            
            Text(name)
                .font(.caption)
                .foregroundStyle(.appPrimary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            TextField(isBp ? "-/-" : "- -", text: $value)
                .font(.headline)
                .bold()
                .foregroundStyle(.appPrimary)
                .multilineTextAlignment(.center)
                .keyboardType(keyboardtype)
                .focused($isCardFocused)
            
            Text(unit)
                .font(.caption)
                .foregroundStyle(.appPrimary)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .frame(maxWidth: .infinity, minHeight: dynamicTypeSize.isAccessibilitySize ? 420 : nil)
        .padding(padding)
        .background(Color.selected)
        .cornerRadius(12)
        .onTapGesture {
            isCardFocused = true
        }
    }
}

#Preview {
    VitalPillView(
        name: "temperature", unit: "celcius", systemIcon: "thermometer.variable", value: .constant("")
    )
    .padding()
}

#Preview("Accessibility Text Scale") {
    VitalPillView(
        name: "temperature", unit: "celcius", systemIcon: "thermometer.variable", value: .constant("36.5")
    )
    .padding()
    .environment(\.dynamicTypeSize, .accessibility3)
}
