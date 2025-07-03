//
//  AddProjetoVazioView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 02/07/25.
//

import SwiftUI
import PhotosUI
import CoreData

struct AddProjetoVazioView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var nomeProjeto: String
    @StateObject var projetoVM = ProjetosViewModel()
    @Environment(\.managedObjectContext) private var contexto
    @State private var foto: UIImage?
    @State private var showImagePicker: Bool = false

    @State private var projeto: Projeto?
    @State private var showingAlert = false
    



    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("NOME DO PROJETO")
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    TextField("Nome", text: $nomeProjeto)
                        .padding()
                        .frame(height: 40)
                        .background(.white)
                        .cornerRadius(8)
                    
                    Text("Capa")
                        .foregroundColor(.secondary)
                        .padding(.top)
                    Divider()
    //                    .padding(.bottom)
                                
    //                    HStack {
                            
                            Button(action: {
                                self.showImagePicker = true
                            }, label: {
                                HStack {
                                    Text("Importar foto da galeria")
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(.tertiaryLabel))
                                }
                            })
    //                            .padding()
                                .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(selectedImage: $foto)
                                }
                        Divider()
                            
                            

    //                    }
                    }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()

            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//            .padding()
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
                        
                        if nomeProjeto.isEmpty {
                            showingAlert = true
                            
                            return
                        }
                        let novoProjeto = projetoVM.criarProjetoVazio(
                            contexto: contexto,
                            nome: nomeProjeto,
                            foto: foto,
                            projeto: projeto)
                        
                        
                        projetoVM.salvar(contexto: contexto)
                        
                        self.nomeProjeto = ""
                        self.foto = nil
                        dismiss()
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

//struct AddProjetoVazioView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProjetoVazioView()
//    }
//}
