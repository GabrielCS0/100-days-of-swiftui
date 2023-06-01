//
//  ContentView.swift
//  MyHabitTracking
//
//  Created by Gabriel on 31/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.habits) { habit in
                    NavigationLink {
                        HabitDetailView(activities: activities, habit: habit)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(habit.description)
                                .font(.system(size: 15))
                            Text("Completed \(habit.NumberOfTimesCompleted) times")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: removeHabit)
            }
            .preferredColorScheme(.dark)
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivity(activities: activities)
            }
        }
    }
    
    func removeHabit(at offsets: IndexSet) {
        activities.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
