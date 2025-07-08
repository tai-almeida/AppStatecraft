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
    @State private var sessaoSelecionada: Sessao? = nil
    @State private var mostrarModal = false
//    @Environment(\.dismiss) var dismiss
    
    @FetchRequest var sessoesDoProjeto: FetchedResults<Sessao>
    
    @Environment(\.dismiss) var dismiss
    
    init(projeto: Projeto) {
        self.projeto = projeto
        self._sessoesDoProjeto = FetchRequest<Sessao>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Sessao.data, ascending: false)], // organiza por data
            predicate: NSPredicate(format: "projeto == %@", projeto) // 'filtra' pra verificar quais sessoes pertencem
            )                                                        // ao projeto e exibir
    }
    
    private func sessoesFiltradas() -> [Sessao] {
        if textoDaBusca.isEmpty {
            return Array(sessoesDoProjeto)
        } else {
            return sessoesDoProjeto.filter {
                CardAtividadesView(sessao: $0).textoPesquisavel
                    .localizedCaseInsensitiveContains(textoDaBusca)
            }
        }
    }
    
//    @ViewBuilder
//    private func verificaSessao() -> some View {
//
//
//    }

    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView() {
                
                ForEach(sessoesFiltradas(), id: \.self) { sessao in
                    Button(action: {
                        sessaoSelecionada = sessao
                        
//                        DispatchQueue.main.async {
                            mostrarModal = true
//                        }
                    }) {
                        CardAtividadesView(sessao: sessao)
                            
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    //.listRowBackground(Color.clear)
                }
            }
//            .listRowBackground(.clear)

        }
        .background(Color(.systemGroupedBackground))
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
        .fullScreenCover(item: $sessaoSelecionada) { sessao in
            if let sessao = sessaoSelecionada {
                    if let multimidia = sessao as? SessaoDesafioMult {
                         MultimidiaSalvoView(sessao: multimidia)
                    } else if let freewriting = sessao as? SessaoFreeWriting {
                         FreeWritingSalvo(sessao: freewriting)
                    } else if let pingpong = sessao as? SessaoPingPong {
                         PingPongSalvoView(sessao: pingpong)
                    } else if let maieutica = sessao as? SessaoMaieutica {
                         MaieuticaSalvoView(sessao: maieutica)
                    } else {
                         Text("Tipo de sessão desconhecido")
                    }
                }
                else {
                    Text("")
//                    Button("Fechar") {
//                        dismiss()
//                    }
                    .onAppear {
                        dismiss()
                    }
                }
        }
    }
}
