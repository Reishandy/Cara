//
//  NavigationRouter.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import SwiftUI

@MainActor
@Observable
class NavigationRouter {
	var path = NavigationPath()
	
	func reset() {
		path = NavigationPath()
	}
}
