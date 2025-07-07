//
//  DetalhesProjetoView.swift
//  AppStatecraft
//
//  Created by Aluno 07 on 26/06/25.
//

import Foundation
import SwiftUI
import CoreData

struct DetalhesProjetoView: View {
    
    @ObservedObject var projeto: Projeto
    
    @FetchRequest var sessoesDoProjeto: FetchedResults<Sessao>
    
    @Environment(\.dismiss) var dismiss
    
    init(projeto: Projeto) {
        self.projeto = projeto
        self._sessoesDoProjeto = FetchRequest<Sessao>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Sessao.data, ascending: false)], // organiza por data
            predicate: NSPredicate(format: "projeto == %@", projeto) // 'filtra' pra verificar quais sessoes pertencem
            )                                                        // ao projeto e exibir
    }
    
    var body: some View {
        
        List() {
            ForEach(sessoesDoProjeto) { sessao in
                CardAtividadesView(sessao: sessao)
            }
        }
        
        .navigationTitle(projeto.nome ?? "Sem Nome")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button (action: {dismiss()}) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Projetos")
                    }
                }
            }
        }
        
    }
}
