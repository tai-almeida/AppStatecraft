//
//  DetalhesProjetoView.swift
//  AppStatecraft
//
//  Created by Aluno 07 on 26/06/25.
//

import Foundation
import SwiftUI
import CoreData

struct detalhesProjetoView: View {
    
    @ObservedObject var projeto: Projeto
    
    @FetchRequest var sessoesDoProjeto: FetchedResults<Sessao>
    
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
                
            }
            
            
        }
        
    }
}
