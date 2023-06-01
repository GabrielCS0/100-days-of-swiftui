//
//  AddActivity.swift
//  MyHabitTracking
//
//  Created by Gabriel on 31/05/23.
//

import SwiftUI

struct AddActivity: View {
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add activity")
            .toolbar {
                Button("Save") {
                    let activity = Activity(name: name, description: description, NumberOfTimesCompleted: 0)
                    activities.habits.append(activity)
                    dismiss()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
