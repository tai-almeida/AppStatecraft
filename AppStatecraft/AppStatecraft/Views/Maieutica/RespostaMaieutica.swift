//
//  RespostaMaieutica.swift
//  AppStatecraft
//
//  Created by Aluno 03 on 27/06/25.
//

import SwiftUI

struct RespostaMaieutica: View {
    @Binding var respostaTexto: String
    
    var body: some View {
        ZStack{
            ZStack(alignment: .topLeading) {
                Text(respostaTexto + "\n")
                    .font(.body)
                    .padding(8)
                    .foregroundColor(.black)
                    .accessibilityHidden(true)
                
                TextEditor(text: $respostaTexto)
                    .font(.body)
                
                // Placeholder para o TextEditor
                
                if respostaTexto.isEmpty {
                    Text("Digite sua resposta aqui...")
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(8)
                        .allowsHitTesting(false) // Permite que o toque "passe" para o TextEditor
                }
            }
        }
        Spacer()
    }
    
}

/*struct RespostaMaieutica_Previews: PreviewProvider {
    static var previews: some View {
        RespostaMaieutica()
    }
}*/
