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
    @StateObject private var projetosVM = ProjetosViewModel()
    private let colunaCard = [GridItem(.flexible()), GridItem(.flexible())]
    @Binding var metodologiaAparecendo: Bool
    @State var sessao: Sessao?
    @State private var telaCriarNovoProjeto = false
    
    @State private var projetosConcluidos = "Em andamento"
    @State private var textoDaBusca = "" // estado local para a busca
    var desafio: QuestaoDesafios?
    @StateObject private var desafiosVM = DesafiosMultimidiaViewModel()
    
    private var projetosFiltrados: [Projeto] {
        let projetosPorStatus: [Projeto]
        
        if projetosConcluidos == "Em andamento" {
            projetosPorStatus = projetosVM.projetos.filter { !$0.finalizado }
        } else {
            projetosPorStatus = projetosVM.projetos.filter { $0.finalizado }
        }
        
        //busca vazia, não precisa filtrar mais nada
        if textoDaBusca.isEmpty {
            return projetosPorStatus
        }
        
        //resultado anterior pelo texto da busca
        return projetosPorStatus.filter { projeto in
            projeto.nome?.localizedCaseInsensitiveContains(textoDaBusca) ?? false
        }
    }

    var body: some View {
        NavigationView {
            VStack() {
                
                Picker("", selection: $projetosConcluidos) {
                    Text("Em andamento").tag("Em andamento")
                    Text("Concluido").tag("Concluido")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                VStack(alignment: .center){
                    ScrollView{
                        
                        if projetosFiltrados.isEmpty{
                            Text("Nenhum projeto encontrado.")
                        }
                        
                        LazyVGrid(columns: colunaCard, spacing: 20) {
                            ForEach(projetosFiltrados, id: \.self) { projeto in
                                Button(action:{
                                    if let sessao = sessao{
                                        projeto.addToSessoes(sessao)
                                        projetosVM.salvar(contexto: contexto)
                                        
                                    }
                                    if desafio != nil {
                                        desafiosVM.desafioConcluido(desafioRealizado: desafio!)
                                        desafiosVM.atualizaJson()
                                    }
                                    dismiss()
                                    self.metodologiaAparecendo = false
                                }){
                                    projetoCardView(projeto: projeto)
                                }
                            }
                        }
                    }.sheet(isPresented: $telaCriarNovoProjeto) {
                        //criarEAddProjetoView(isPresented: $telaCriarNovoProjeto)
                    }
                }
                //.frame(maxWidth: .infinity) nao sei o quanto isso realmente eh necessario
                .padding(.horizontal)
            }
            .navigationBarTitle(Text("Meus Projetos"))
            .searchable(text: $textoDaBusca)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button(action: {
                    //self.telaCriarNovoProjeto = true
                }) {
                    Image(systemName: "plus")
                }).foregroundColor(.accentColor)
        }.onAppear {
            projetosVM.getAllProjetos(contexto: contexto)
        }
    }
}
