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
    
    @Environment(\.dismiss) var dismiss
    
    init(projeto: Projeto) {
        self.projeto = projeto
        self._sessoesDoProjeto = FetchRequest<Sessao>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Sessao.data, ascending: false)], // organiza por data
            predicate: NSPredicate(format: "projeto == %@", projeto) // 'filtra' pra verificar quais sessoes pertencem
            )                                                        // ao projeto e exibir
    }

    
    var body: some View {
        VStack(alignment: .center) {
            List() {
                if textoDaBusca.isEmpty {
                    ForEach(sessoesDoProjeto) { sessao in
                        if let multimidia = sessao as? SessaoDesafioMult {
                            NavigationLink(destination: MultimidiaSalvoView(sessao: multimidia)) {
                                CardAtividadesView(sessao: multimidia)
                            }
                        } else if let freewriting = sessao as? SessaoFreeWriting {
                            NavigationLink(destination: FreeWritingSalvo(sessao: freewriting)) {
                                CardAtividadesView(sessao: freewriting)
                            }
                        } else if let pingpong = sessao as? SessaoPingPong {
                            NavigationLink(destination: PingPongSalvoView(sessao: pingpong)) {
                                CardAtividadesView(sessao: pingpong)
                            }
                        } else if let maieutica = sessao as? SessaoMaieutica {
                            NavigationLink(destination: MaieuticaSalvoView(sessao: maieutica)) {
                                CardAtividadesView(sessao: maieutica)
                            }
                        }
                        
                        
                    }
                    
                } else {
                    ForEach(sessoesDoProjeto.filter {
                        CardAtividadesView(sessao: $0).textoPesquisavel
                            .localizedCaseInsensitiveContains(textoDaBusca)
                    }) { sessao in
                        if let multimidia = sessao as? SessaoDesafioMult {
                            NavigationLink(destination: MultimidiaSalvoView(sessao: multimidia)) {
                                CardAtividadesView(sessao: multimidia)
                            }
                        } else if let freewriting = sessao as? SessaoFreeWriting {
                            NavigationLink(destination: FreeWritingSalvo(sessao: freewriting)) {
                                CardAtividadesView(sessao: freewriting)
                            }
                        } else if let pingpong = sessao as? SessaoPingPong {
                            NavigationLink(destination: PingPongSalvoView(sessao: pingpong)) {
                                CardAtividadesView(sessao: pingpong)
                            }
                        } else if let maieutica = sessao as? SessaoMaieutica {
                            NavigationLink(destination: MaieuticaSalvoView(sessao: maieutica)) {
                                CardAtividadesView(sessao: maieutica)
                            }
                        }
                    }
                }
                
            }
            
        }
        .frame(maxWidth: .infinity)
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
        .searchable(text: $textoDaBusca, placement: .navigationBarDrawer(displayMode: .always))
        
    }
}
