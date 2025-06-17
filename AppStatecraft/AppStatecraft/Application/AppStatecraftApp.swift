//
//  AppStatecraftApp.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 11/06/25.
//

import SwiftUI

@main
struct AppStatecraftApp: App {
    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
