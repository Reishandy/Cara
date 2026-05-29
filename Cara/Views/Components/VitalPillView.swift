//
//  VitalPillView.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 29/05/26.
//

import SwiftUI

struct VitalPillView: View {
	let title: String
	let unit: String
	let systemIcon: String
	
	// FIXME: Dynamic type using generic T?
	@Binding var value: String
	
	// FIXME: Change color
	var body: some View {
		HStack(spacing: 10) {
			ZStack {
				Image(systemName: systemIcon)
				
				Circle()
					.frame(width: 40)
					.foregroundStyle(.black.opacity(0.5))
			}
			
			VStack(alignment: .leading, spacing: 4) {
				Text(title)
					.bold()
				
				HStack(alignment: .center, spacing: 4) {
					TextField(". . .", text: $value)
						.frame(width: 20)
						.padding(.leading, 4)
						.padding(.horizontal, 6)
						.padding(.vertical, 2)
						.overlay(
							RoundedRectangle(cornerRadius: 10)
								.stroke(.black.opacity(0.5), lineWidth: 1)
						)
					
					Text(unit)
						.font(.callout)
						.foregroundStyle(.black.opacity(0.5))
				}
			}
		}
		.frame(maxWidth: .infinity)
	}
}

#Preview {
	// FIXME: Updatable preview
	
	VitalPillView(
		title: "Temperature", unit: "celcius", systemIcon: "thermometer.variable", value: .constant("")
	)
	.padding()
}
