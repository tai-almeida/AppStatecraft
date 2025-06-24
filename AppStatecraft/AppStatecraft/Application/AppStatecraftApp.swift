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
//            //MetodologiasView()
            TabBar()
//            DesafiosMultimidiaView(enunciado: "Escreva uma curta historia a partir desse quadro")
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
       
    }
}
