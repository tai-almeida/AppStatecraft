////
////  CriarEAddProjetoView.swift
////  AppStatecraft
////
////  Created by Aluno 07 on 30/06/25.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//  Created by Aluno 07 on 30/06/25.
//

import Foundation
import SwiftUI
import CoreData

struct criarEAddProjetoView: View {
    
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @Binding var nomeNovoProjeto: String
    @Binding var sessao: Sessao
 //   @Binding var addProjAparecendo: Bool
   // @Binding var metodologiaAparecendo: Bool
    @StateObject var projetoVM = ProjetosViewModel()
    
    
    @State private var foto: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Nome do Projeto")
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    TextField("Nome", text: $nomeNovoProjeto)
                        .padding()
                        .frame(height: 40)
                        .background(.white)
                        .cornerRadius(8)
                    
                    Text("Capa")
                        .foregroundColor(.secondary)
                        .padding(.top)
                    Divider()
                            
                            Button(action: {
                                self.showImagePicker = true
                            }, label: {
                                HStack {
                                    Text("Importar foto da galeria")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(.tertiaryLabel))
                                }
                                .padding()
                                .frame(height: 40)
                                .background(.white)
                                .cornerRadius(8)
                            })
                                .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(selectedImage: $foto)
                                }
                        Divider()
                            
                    }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()

            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(UIColor.secondarySystemBackground))
            .navigationTitle("Adicionar Projeto")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        
                        if nomeNovoProjeto.isEmpty {
                            showingAlert = true
                            
                            return
                        }
                        
                        let novoProjetoComSessao = projetoVM.criarProjComSessao(
                            contexto: viewContext,
                            nome: nomeNovoProjeto,
                            foto: foto,
                            sessao: sessao
                        )
                        
                        projetoVM.salvar(contexto: viewContext)
                        
                        self.nomeNovoProjeto = ""
                        self.foto = nil
                        dismiss()
                       // self.addProjAparecendo = false
                       // self.metodologiaAparecendo = false
                    }
                    .alert("Nome inválido", isPresented: $showingAlert) {
                        Button("Ok", role: .cancel) { }
                    } message: {
                        Text("O nome do projeto não pode estar vazio. Insira um nome, por favor!")
                    }
                    
                }
            }
        }
    }
  }

