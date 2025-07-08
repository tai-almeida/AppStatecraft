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
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
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
                ZStack(alignment: .topLeading) {
                    Text(respostaTexto + "\n")
                        .font(.body)
                        .padding(12)
                        .foregroundColor(.black)
                        .accessibilityHidden(true)
                    
                    TextEditor(text: $respostaTexto)
                        .font(.body)
                        .padding(.horizontal, 12)
                    
                    // Placeholder para o TextEditor
                    
                    if respostaTexto.isEmpty {
                        Text("Digite sua resposta aqui...")
                            .foregroundColor(.gray.opacity(0.7))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 9)
                            .allowsHitTesting(false) // Permite que o toque "passe" para o TextEditor
                    }
                    /*Text(respostaTexto)
                        .font(.body)
                        .foregroundColor(.clear)
                        .accessibilityHidden(true)
                        .padding()
                    
                    TextEditor(text: $respostaTexto)
                        .font(.body)
                    
                    if respostaTexto.isEmpty {
                        Text("Digite sua resposta aqui...")
                            .foregroundColor(.gray.opacity(0.7))
                            .padding(12)
                            .allowsHitTesting(false) 
                    }*/
                }
            }
            Spacer()
        }
    }
}

