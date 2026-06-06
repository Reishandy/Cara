//
//  RoutineFormView.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 06/06/26.
//

import SwiftUI

struct RoutineFormView: View {
	@Binding var name: String
	@Binding var description: String
	
	var body: some View {
		VStack(spacing: 12) {
			Text("Routine Name")
				.font(.title2)
				.bold()
				.foregroundStyle(.appPrimary)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			TextField("", text: $name)
				.foregroundStyle(.appPrimary)
				.padding(16)
				.background {
					RoundedRectangle(cornerRadius: 16)
						.fill(Color.selected.opacity(0.8))
				}
			
			Text("Routine Description")
				.font(.title2)
				.bold()
				.foregroundStyle(.appPrimary)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			TextEditor(text: $description)
				.foregroundStyle(.appPrimary)
				.padding(16)
				.background {
					RoundedRectangle(cornerRadius: 16)
						.fill(Color.selected.opacity(0.8))
				}
				.scrollContentBackground(.hidden)
				.frame(height: 120)
		}
	}
}

#Preview {
	RoutineFormView(name: .constant(""), description: .constant(""))
}
