//
//  VitalPillView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI

struct VitalPillView: View {
    @ScaledMetric(relativeTo: .body) private var spacing = 10
    @ScaledMetric(relativeTo: .body) private var padding = 12
    
	let unit: String
	let systemIcon: String
	
	// FIXME: Dynamic type using generic T?
	@Binding var value: String
	
	var body: some View {
        VStack(alignment: .center, spacing: spacing) {
            Image(systemName: systemIcon)
                .font(.title2)
                .foregroundStyle(.appPrimary)
            
            TextField("- -", text: $value)
                .font(.subheadline)
                .bold()
                .foregroundStyle(.appSecondary)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
            
            Text(unit)
                .font(.caption)
                .foregroundStyle(.appPrimary)
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .frame(maxWidth: .infinity)
        .padding(padding)
        .background(Color.selected)
        .cornerRadius(12)
        
        

		.frame(maxWidth: .infinity)
	}
}

#Preview {
	// FIXME: Updatable preview
	
	VitalPillView(
		unit: "celcius", systemIcon: "thermometer.variable", value: .constant("")
	)
	.padding()
}

#Preview("Accessibility Text Scale") {
    VitalPillView(
        unit: "celcius", systemIcon: "thermometer.variable", value: .constant("36.5")
    )
    .padding()
    .environment(\.dynamicTypeSize, .accessibility3)
}
