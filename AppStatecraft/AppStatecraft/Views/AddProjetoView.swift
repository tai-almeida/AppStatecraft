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
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Projeto.data, ascending: false)])
   
    private var projetos: FetchedResults<Projeto>
    let respostaTexto: String?
    let respostaFoto: UIImage? //ver depois de passar como objeto mesmo para ficar mais legivel
    let desafio: QuestaoDesafios
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    @State private var minhaIdeiaModal = false
    @State private var telaCriarNovoProjeto = false
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(projetos, id: \.self) { projeto in
                            NavigationLink(destination: detalhesProjetoView(projeto: projeto)) {
                                Text(projeto.nome ?? "Sem nome")
                            }
                        }
                    }
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
                    }
            )
            
          //  .sheet(isPresented: $telaCriarNovoProjeto)
            
            
            
            
            
            
            
            
            
            
            VStack() {
//                HStack(alignment: .top) {
//                    Image(systemName: "plus")
//                        .foregroundColor(Color.accentColor)
//                }
                    Button {
                        minhaIdeiaModal = true
                    } label: {
                        Image(systemName: "lightbulb.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.yellow)
                            .padding(30)
                            .background(Color.yellow.opacity(0.1))
                            .cornerRadius(20)
                            .shadow(radius: 6)
                            .frame(width: 200, height: 200)
                    }
                    // Texto fora do botão/card
                    Text("Esboço")
                        .frame(width: 200, alignment: .leading)
                        .font(.headline)
                        .foregroundColor(.primary)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }.foregroundColor(.accentColor)
                }
            }
            .navigationTitle("Meus Projetos")
            
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                .padding([.top, .leading], 20)
                // Modal vazio
                .sheet(isPresented: $minhaIdeiaModal) {
                    // Modal content — pode personalizar depois
                    VStack {
                        Text("Aqui vai ser guardado os rascunhos?")
                            .font(.title)
                        Spacer()
                    }
                    .padding()
                }
            }
//        .toolbar {
//            ToolbarItem(placement: .cancellationAction) {
//                Button("Cancelar") {
//                    dismiss()
//                }.foregroundColor(.accentColor)
//            }
//        }
    }}
