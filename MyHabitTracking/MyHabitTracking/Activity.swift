//
//  Activity.swift
//  MyHabitTracking
//
//  Created by Gabriel on 31/05/23.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var NumberOfTimesCompleted: Int
}
