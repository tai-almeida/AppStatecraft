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
                        //criarEAddProjetoView(isPresented: $telaCriarNovoProjeto)
                    }
                }
                //.frame(maxWidth: .infinity) nao sei o quanto isso realmente eh necessario
                .padding(.horizontal)
                
                
                
            }
            .navigationBarTitle(Text("Meus Projetos"))
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

//    private func salvarSessao(em projeto: Projeto) {
//        switch desafio.tipo {
//        case "maieutica":
//            let novaSessao = SessaoMaieutica(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.log = Data()
//            
//            novaSessao.projeto = projeto
//        
//        case "multimidia":
//            let novaSessao = SessaoDesafioMult(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.desafioFeito = Bool()
//            novaSessao.desafioID = Int64()
//            novaSessao.enunciado = String()
//            novaSessao.mediaFoto = Data()
//            novaSessao.mediaTexto = String()
//            novaSessao.respostaFoto = Data()
//            novaSessao.respostaTexto = String()
//            
//            novaSessao.projeto = projeto
//            
//        case "free writing":
//            let novaSessao = SessaoFreeWriting(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.enunciado = String()
//            novaSessao.resposta = String()
//            
//            novaSessao.projeto = projeto
//            
//        case "ping pong":
//            let novaSessao = SessaoPingPong(context: viewContext)
//            novaSessao.id = UUID()
//            novaSessao.data = Date()
//            
//            novaSessao.log = Data()
//            
//            novaSessao.projeto = projeto
//        
//        default:
//            print("tipo invalido")
//            return
//            
//        }
//        
//        do {
//            try viewContext.save()
//            print("eeeeeee :)")
//            dismiss()
//        } catch {
//            let nsError = error as NSError
//            print("aaaah :( \(nsError)")
//        }
//    }
            
    
            

            
            
            
            
            
//
//
//            VStack() {
////                HStack(alignment: .top) {
////                    Image(systemName: "plus")
////                        .foregroundColor(Color.accentColor)
////                }
//                    Button {
//                        minhaIdeiaModal = true
//                    } label: {
//                        Image(systemName: "lightbulb.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 60, height: 60)
//                            .foregroundColor(.yellow)
//                            .padding(30)
//                            .background(Color.yellow.opacity(0.1))
//                            .cornerRadius(20)
//                            .shadow(radius: 6)
//                            .frame(width: 200, height: 200)
//                    }
//                    // Texto fora do botão/card
//                    Text("Esboço")
//                        .frame(width: 200, alignment: .leading)
//                        .font(.headline)
//                        .foregroundColor(.primary)
//            }
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancelar") {
//                        dismiss()
//                    }.foregroundColor(.accentColor)
       //     VStack() {
//                HStack(alignment: .top) {
//                    Image(systemName: "plus")
//                        .foregroundColor(Color.accentColor)
        //      }
//            }
//            .navigationTitle("Meus Projetos")
//
////                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
////                .padding([.top, .leading], 20)
//                // Modal vazio
//                .sheet(isPresented: $minhaIdeiaModal) {
//                    // Modal content — pode personalizar depois
//                    VStack {
//                        Text("Aqui vai ser guardado os rascunhos?")
//                            .font(.title)
//                        Spacer()
//                    }
//                    .padding()
//                }
//            }
////        .toolbar {
////            ToolbarItem(placement: .cancellationAction) {
////                Button("Cancelar") {
////                    dismiss()
////                }.foregroundColor(.accentColor)
////            }
 //   }

}
