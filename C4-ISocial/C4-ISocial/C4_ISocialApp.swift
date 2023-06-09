//
//  C4_ISocialApp.swift
//  C4-ISocial
//
//  Created by Gabriel on 05/06/23.
//

import SwiftUI

@main
struct C4_ISocialApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
