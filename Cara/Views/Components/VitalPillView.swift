//
//  VitalPillView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI

struct VitalPillView: View {
	let unit: String
	let systemIcon: String
	
	// FIXME: Dynamic type using generic T?
	@Binding var value: String
	
	var body: some View {
        VStack(alignment: .center, spacing: 10) {
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
            
        }
        .frame(maxWidth: .infinity)
        .padding(12)
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
