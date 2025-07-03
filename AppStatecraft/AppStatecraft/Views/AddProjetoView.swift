//
//  AddProjetoView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 24/06/25.
//

import SwiftUI
import CoreData

struct AddProjetoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var contexto
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Projeto.data, ascending: false)])
    private var projetos: FetchedResults<Projeto>
    private let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    @Binding var metodologiaAparecendo: Bool
    @State var sessao: Sessao?
    @State private var telaCriarNovoProjeto = false
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(projetos, id: \.self) { projeto in
                            
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Meus Projetos"))
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                    self.metodologiaAparecendo = false
                },
                trailing: Button(action: {
                    self.telaCriarNovoProjeto = true
                }) {
                    Image(systemName: "plus")
                }).foregroundColor(.accentColor)
            }
    }
}
