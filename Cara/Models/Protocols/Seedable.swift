//
//  Seedable.swift
//  Cara
//
//  Created by Muhammad Akbar Reishandy on 02/06/26.
//

import SwiftData

nonisolated protocol Seedable: PersistentModel {
	static var defaultData: [Self] { get }
}
