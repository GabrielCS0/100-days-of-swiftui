//
//  HabitDetailView.swift
//  MyHabitTracking
//
//  Created by Gabriel on 31/05/23.
//

import SwiftUI

struct HabitDetailView: View {
    var activities: Activities
    let habit: Activity
    
    var body: some View {
        Form {
            Text(habit.description)
            Stepper(
                onIncrement: { updateNumberOfTimesCompleted(by: 1) },
                onDecrement: { updateNumberOfTimesCompleted(by: -1) },
                label: { Text("Completed \(habit.NumberOfTimesCompleted) times") }
            )
        }
        .navigationTitle(habit.name)
        .preferredColorScheme(.dark)
    }
    
    func updateNumberOfTimesCompleted(by number: Int) {
        var modifiedHabit = habit
        modifiedHabit.NumberOfTimesCompleted += number

        let habitIndex = activities.habits.firstIndex(of: habit)!
        activities.habits[habitIndex] = modifiedHabit
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(
            activities: Activities(),
            habit: Activity(
                name: "Work out",
                description: "100 situps, 100 pushups, 100 squats, run 10km.",
                NumberOfTimesCompleted: 1096
            )
        )
    }
}
