//
//  AddProjetoVazioView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 02/07/25.
//

import SwiftUI

struct AddProjetoVazioView: View {
    @Binding var nomeProjeto: String
    
    var body: some View {
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
                .padding(.bottom)
                        
            Button(action: {
                
            }) {
                HStack {
                    Text("Escolher fotos existentes")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(.tertiaryLabel))
                        .background(.white)


                }
            }
                
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))

        
    }
}

//struct AddProjetoVazioView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProjetoVazioView()
//    }
//}
