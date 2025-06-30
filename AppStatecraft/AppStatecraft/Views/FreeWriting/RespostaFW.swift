//
//  RespostaCard.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 18/06/25.
//

import SwiftUI

struct RespostaFW: View {
    @Binding var respostaTexto: String
    
    var body: some View {
        ZStack{
            
            ZStack(alignment: .topLeading) {
                Text(respostaTexto + "\n")
                    .font(.body)
                    .foregroundColor(.clear)
                    .accessibilityHidden(true)
                
                TextEditor(text: $respostaTexto)
                    .font(.body)
                
                // Placeholder para o TextEditor
                
                if respostaTexto.isEmpty {
                    Text("Digite sua resposta aqui...")
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(12)
                        .allowsHitTesting(false) // Permite que o toque "passe" para o TextEditor
                }
            }
            
            Spacer()
        }
        
    }
}

