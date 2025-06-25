//
//  TabBar.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 17/06/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            MetodologiasView()
                .tabItem {
                    Label("Metodologias", systemImage: "calendar")
                }
            
            Text("Tela Registros")
                .tabItem {
                    Label("Registros", systemImage: "book")
                }
            
            ProjetosView()
                .tabItem {
                    Label("Projetos", systemImage: "folder")
                }
                
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

