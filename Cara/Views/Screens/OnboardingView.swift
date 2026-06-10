//
//  OnboardingView.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 09/06/26.
//

import SwiftUI

struct OnboardingView: View {
	@Binding var hasSeenOnboarding: Bool
	
	var body: some View {
		ZStack(alignment: .bottom) {
			VStack(spacing: 36) {
				VStack(spacing: 4) {
					Text("Cara")
						.font(.largeTitle)
						.bold()
						.foregroundStyle(.appPrimary)
					
					Text("Post-Stroke Care")
						.font(.title2)
						.foregroundStyle(.appThird)
				}
				
				Image("cara")
				
				VStack(spacing: 12) {
					Text("Thank you for choosing to be a caregiver.")
						.font(.title2)
						.bold()
						.foregroundStyle(.appPrimary)
					
					Text("Cara is here to guide you, one step at a time, in language you actually understand.")
						.foregroundStyle(.appPrimary)
				}
			}
			.padding(.horizontal, 50)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			Button {
				hasSeenOnboarding = true
			} label: {
				Text("Get Started")
					.font(.headline)
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding(.vertical, 16)
			}
			.glassEffect(.regular.tint(.appThird))
			.padding(.horizontal, 20)
			.padding(.top, 24)
		}
		.multilineTextAlignment(.center)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background {
			LinearGradient(
				colors: [.onboardingBottomGradient, .onboardingTopGradient],
				startPoint: .bottom,
				endPoint: UnitPoint(x: 0.5, y: -0.2)
			)
			.ignoresSafeArea()
		}
	}
}

#Preview {
	OnboardingView(hasSeenOnboarding: .constant(false))
}
