//
//  AddProjetoVazioView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 02/07/25.
//

import SwiftUI

struct AddProjetoVazioView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var nomeProjeto: String
    
    var body: some View {
        NavigationView {
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
                            
                Button(action: {
                    
                }) {
                    HStack {
                        Text("Escolher fotos existentes")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.tertiaryLabel))

                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
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
                        // chamar funcao criarNovoProjeto(nome: nomeProjeto, foto: foto)
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
