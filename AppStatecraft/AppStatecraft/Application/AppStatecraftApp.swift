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
    
    init() {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.accentColor)
            UIPageControl.appearance().pageIndicatorTintColor = UIColor(.secondary)
    }
    
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
