//
//  RespostaCard.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 18/06/25.
//

import SwiftUI

struct RespostaCard: View {
    @Binding var image: UIImage?
    @Binding var respostaTexto: String

    var body: some View {
        ZStack{
            if let image = image
            {
                // SE TIVER UMA IMAGEM: mostre a imagem
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding() // Um pequeno respiro para a imagem não colar na borda
                
                // Botão para REMOVER a imagem e voltar a digitar
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            self.image = nil // Limpa a imagem
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
                .padding(12)
                
            } else {
                // SE NÃO TIVER IMAGEM: mostre o editor de texto
                TextEditor(text: $respostaTexto)
                    .padding(4)
                
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

