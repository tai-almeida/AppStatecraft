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
            MaieuticaTelaInicio()
                .tabItem {
                    Label("Metodologias", systemImage: "calendar")
                }
            
            Text("Tela Registros")
                .tabItem {
                    Label("Registros", systemImage: "book")
                }
            
            Text("Tela de Projetos")
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

