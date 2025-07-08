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
    @Binding var metodologiaAparecendo: Bool
   // @Binding var addProjAparecendo: Bool
    @State var sessao: Sessao?
    @State private var telaCriarNovoProjeto = false
    @State private var projetosConcluidos = "Em andamento"
    @State var nomeNovoProjeto = ""
    @State private var textoDaBusca = "" // estado local para a busca
    private let colunaCard = [GridItem(.flexible()), GridItem(.flexible())]
    var desafio: QuestaoDesafios?
    @StateObject private var desafiosVM = DesafiosMultimidiaViewModel()
    @StateObject private var freewritingVM = FreeWritingViewModel()
    var prompt: PromptFW?
    
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
                
                //                Picker("", selection: $projetosConcluidos) {
                //                    Text("Em andamento").tag("Em andamento")
                //                    Text("Concluido").tag("Concluido")
                //                }
                //                .pickerStyle(.segmented)
                //                .padding(.horizontal)
                
                VStack(alignment: .center){
                    ScrollView{
                        
                        if projetosFiltrados.isEmpty{
                            TelaVaziaProjeto()
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
                                    if prompt != nil {
                                        freewritingVM.promptConcluido(promptRealizado: prompt!)
                                        freewritingVM.atualizaJson()
                                    }
                                    dismiss()
                                    self.metodologiaAparecendo = false
                                }){
                                    projetoCardView(projeto: projeto)
                                }
                                .contextMenu { // .contextMenu para o long press
                                    Button(action: {
                                        projetosVM.toggleConcluidoProjeto(viewContext: contexto, projeto: projeto)
                                    }) {
                                        Label(projeto.finalizado ? "Marcar como Em Andamento" : "Marcar como Concluído",
                                              systemImage: projeto.finalizado ? "arrow.uturn.backward.circle" : "checkmark.circle")
                                    }
                                    
                                    Button(role: .destructive, action: {
                                        projetosVM.deletarProjeto(viewContext: contexto, projeto: projeto)
                                    }) {
                                        Label("Deletar", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }.sheet(isPresented: $telaCriarNovoProjeto) {
                        if let sessao = sessao {
                            criarEAddProjetoView(
                                isPresented: $telaCriarNovoProjeto,
                                nomeNovoProjeto: $nomeNovoProjeto,
                                sessao: .constant(sessao)
                              //  addProjAparecendo: $addProjAparecendo
                              //  metodologiaAparecendo: $metodologiaAparecendo
                            )
                        }
                       
                    }
                    .padding(.horizontal)
                }
                .navigationBarTitle(Text("Meus Projetos"))
                .searchable(text: $textoDaBusca, placement: .navigationBarDrawer(displayMode: .always)) //para a busca ficar fixa la em cima
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
}
