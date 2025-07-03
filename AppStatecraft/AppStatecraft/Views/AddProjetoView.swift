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
    @State private var projetos: [Projeto] = []
    private let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    @Binding var metodologiaAparecendo: Bool
    @State var sessao: Sessao?
    @State private var telaCriarNovoProjeto = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(projetos, id: \.self) { projeto in
                            Button(action:{
                                //aqui eh para salvar o contexto
                                dismiss()
                                self.metodologiaAparecendo = false
                            }){
                                Text(projeto.nome ?? "vazio")
                            }
                        }
                    }
                }.sheet(isPresented: $telaCriarNovoProjeto) {
                    //criarEAddProjetoView(isPresented: $telaCriarNovoProjeto)
                }
            }
            .navigationBarTitle(Text("Meus Projetos"))
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button(action: {
                    self.telaCriarNovoProjeto = true
                }) {
                    Image(systemName: "plus")
                }).foregroundColor(.accentColor)
        }.onAppear {
            getAllProjetos(contexto: contexto)
        }
    }
    
    private func getAllProjetos(contexto: NSManagedObjectContext){
        let requisicao = NSFetchRequest<Projeto>(entityName: "Projeto")
        let ordenadorDeData = NSSortDescriptor(keyPath: \Projeto.data, ascending: false) //mais recente para o mais velho
        requisicao.sortDescriptors = [ordenadorDeData]
        
        do {
            projetos = try contexto.fetch(requisicao)
            print("Busca concluída: \(projetos.count) projetos encontradas.")
        } catch let error {
            print("Erro: \(error.localizedDescription)")
        }
    }
}
