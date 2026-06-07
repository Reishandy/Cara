//
//  View.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 07/06/26.
//

import SwiftUI

extension View {
	func hideKeyboardWhenTappedAround() -> some View {
		return self
			.contentShape(Rectangle())
			.onTapGesture {
				UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
			}
	}
}
