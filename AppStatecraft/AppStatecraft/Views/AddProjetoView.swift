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
    //@Binding var pesquisarProjeto: String
    @State private var projetosConcluidos = "Em andamento"
    @State var nomeNovoProjeto = ""

    
    private var projetosFiltrados: [Projeto] {
            if projetosConcluidos == "Em andamento" {
                return projetosVM.projetos.filter { !$0.finalizado }
            } else {
                return projetosVM.projetos.filter { $0.finalizado }
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
                            Text("Não há projetos aqui.")
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
                            )
                        }
                       
                    }
                }
                //.frame(maxWidth: .infinity) nao sei o quanto isso realmente eh necessario
                .padding(.horizontal)
                
                
                
            }
            .navigationTitle("Meus Projetos")
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button(action: {
                    telaCriarNovoProjeto = true

                }) {
                    Image(systemName: "plus")
                }).foregroundColor(.accentColor)
        }.onAppear {
            projetosVM.getAllProjetos(contexto: contexto)
        }
    }
}
