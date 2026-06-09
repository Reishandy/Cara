//
//  ItemFormView.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 06/06/26.
//

import SwiftUI
import SFSymbolsPicker

struct ItemFormView: View {
	var isTask: Bool = false
	@Binding var name: String
	@Binding var description: String
	var categories: [TaskCategory] = []
	@Binding var category: TaskCategory?
	@Binding var icon: String
	
	init(
		isTask: Bool = false,
		name: Binding<String>,
		description: Binding<String>,
		categories: [TaskCategory] = [],
		category: Binding<TaskCategory?> = .constant(nil),
		icon: Binding<String> = .constant("cross.fill")
	) {
		self.isTask = isTask
		self._name = name
		self._description = description
		self.categories = categories
		self._category = category
		self._icon = icon
	}
	
	var body: some View {
		VStack(spacing: 12) {
			Text("\(isTask ? "Task" : "Routine") Name")
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
			
			Text("\(isTask ? "Task" : "Routine") Description")
				.font(.title2)
				.bold()
				.foregroundStyle(.appPrimary)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			TextEditor(text: $description)
				.foregroundStyle(.appPrimary)
				.padding(10)
				.background {
					RoundedRectangle(cornerRadius: 16)
						.fill(Color.selected.opacity(0.8))
				}
				.scrollContentBackground(.hidden)
				.frame(height: 120)
			
			if isTask {
				Text("Task Category")
					.font(.title2)
					.bold()
					.foregroundStyle(.appPrimary)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				Menu {
					Picker("Category", selection: $category) {
						Text("Uncategorized").tag(nil as TaskCategory?)
						
						ForEach(categories, id: \.self) { cat in
							Text(cat.categoryName).tag(cat as TaskCategory?)
						}
					}
					.pickerStyle(.inline)
				} label: {
					HStack {
						Text(category?.categoryName ?? "Uncategorized")
							.font(.body)
						
						Spacer()
						
						Image(systemName: "chevron.up.chevron.down")
							.font(.subheadline)
							.foregroundStyle(.gray)
					}
					.foregroundStyle(.appPrimary)
				}
				.padding(16)
				.background {
					RoundedRectangle(cornerRadius: 16)
						.fill(Color.selected.opacity(0.8))
				}
				
				HStack {
					Text("Task Icon")
						.font(.title2)
						.bold()
						.foregroundStyle(.appPrimary)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					SFSymbolsPicker(selection: $icon, autoDismiss: true) {
						HStack {
							Image(systemName: icon)
								.padding(.trailing, 8)
							
							Image(systemName: "chevron.up.chevron.down")
								.opacity(0.5)
								.font(.subheadline)
								.padding(.trailing, 1)
						}
						.foregroundStyle(.appPrimary)
						.padding(16)
						.background {
							RoundedRectangle(cornerRadius: 16)
								.fill(Color.selected.opacity(0.8))
						}
					}
				}
				.padding(.top, 6)
			}
		}
	}
}

#Preview("Routine") {
	ItemFormView(name: .constant(""), description: .constant(""))
}

#Preview("Task") {
	ItemFormView(
		isTask: true,
		name: .constant(""),
		description: .constant(""),
		categories: [TaskCategory(categoryName: "Category 1"), TaskCategory(categoryName: "Category 2")],
		category: .constant(nil)
	)
}
