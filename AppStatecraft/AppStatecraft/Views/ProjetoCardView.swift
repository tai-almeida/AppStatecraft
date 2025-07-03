//
//  ProjetoCardView.swift
//  AppStatecraft
//
//  Created by Aluno 07 on 25/06/25.
//

import SwiftUI

struct projetoCardView: View {
    
    let projeto: Projeto
    let placeholderImage = UIImage(named: "placeholder")
    
    let colunas = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        VStack{
            if let imagemData = projeto.imagemCapa,
               let uiImage = UIImage(data: imagemData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 120)
                    .clipped()
            } else if let placeholder = placeholderImage {
                Image(uiImage: placeholder)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 120)
                    .clipped()
            }
            
            Text(projeto.nome ?? "Projeto sem nome")
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding(.horizontal, 4)
                .lineLimit(1)
        }
        .frame(width: 150, height: 160)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}

