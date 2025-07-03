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
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    LazyVGrid(columns: colunaCard, spacing: 20) {
                        ForEach(projetosVM.projetos, id: \.self) { projeto in
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
                        }.padding()
                    }.sheet(isPresented: $telaCriarNovoProjeto) {
                        //criarEAddProjetoView(isPresented: $telaCriarNovoProjeto)
                    }
                }
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
}
