//
//  Screen.swift
//  CH3-PM-Team4
//
//  Created by Muhammad Akbar Reishandy on 26/05/26.
//

import Foundation

enum Screen: Hashable {
	case home
	case learn
	case routineDetail(routine: Routine, day: Date)
	case taskSelection
	case taskDetail
}
