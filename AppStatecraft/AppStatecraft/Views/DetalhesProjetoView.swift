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
    @State private var textoDaBusca = "" // estado local para a busca
    
    @FetchRequest var sessoesDoProjeto: FetchedResults<Sessao>
    
    init(projeto: Projeto) {
        self.projeto = projeto
        self._sessoesDoProjeto = FetchRequest<Sessao>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Sessao.data, ascending: false)], // organiza por data
            predicate: NSPredicate(format: "projeto == %@", projeto) // 'filtra' pra verificar quais sessoes pertencem
            )                                                        // ao projeto e exibir
    }

//    private var sessoesFiltradas: [Sessao] {
//
////        sessoesDoProjeto.filter { sessao in
//            if textoDaBusca.isEmpty {
//                return Array(sessoesDoProjeto)
//            } else {
//                return sessoesDoProjeto.filter { sessao in
//                    if let maieutica = sessao as? SessaoMaieutica,
//                             let logData = maieutica.log,
//                       let historico = try? JSONDecoder().decode([PromptResposta].self, from: logData) {
//                        return historico.contains {
//                            $0.resposta.localizedCaseInsensitiveContains(textoDaBusca)
//                        }
//                    }
//                    return false
//                }
//            }
////        }
//    }
    

    
    var body: some View {
        VStack(alignment: .center) {
            List() {
                if textoDaBusca.isEmpty {
                    ForEach(sessoesDoProjeto) { sessao in
                        CardAtividadesView(sessao: sessao)
                    }
                    
                } else {
                    ForEach(sessoesDoProjeto.filter {
                        CardAtividadesView(sessao: $0).textoPesquisavel
                            .localizedCaseInsensitiveContains(textoDaBusca)
                    }) { sessao in
                        CardAtividadesView(sessao: sessao)
                    }
                }
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .navigationTitle(projeto.nome ?? "Sem Nome")
        .searchable(text: $textoDaBusca, placement: .navigationBarDrawer(displayMode: .always))
        
    }
}
