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
   // @Binding var addProjAparecendo: Bool
    @State var sessao: Sessao?
    @State private var telaCriarNovoProjeto = false
    @State private var projetosConcluidos = "Em andamento"
    @State var nomeNovoProjeto = ""
    @State private var textoDaBusca = "" // estado local para a busca
    
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
                                    dismiss()
                                    self.metodologiaAparecendo = false
                                }){
                                    projetoCardView(projeto: projeto)
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
                }
                //.frame(maxWidth: .infinity) nao sei o quanto isso realmente eh necessario
                .padding(.horizontal)
            }
            .navigationTitle("Meus Projetos")
            .searchable(text: $textoDaBusca)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button(action: {
                    telaCriarNovoProjeto = true
                  //  self.addProjAparecendo = false

                }) {
                    Image(systemName: "plus")
                }).foregroundColor(.accentColor)
        }.onAppear {
            projetosVM.getAllProjetos(contexto: contexto)
        }
    }
}
