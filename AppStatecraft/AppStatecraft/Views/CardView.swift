//
//  Carrossel.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 18/06/25.
//

import SwiftUI

struct CardView: View {
    let cor: Color
    let imagem: String
    let titulo: String
    let descricao: String
    let destino: AnyView
    
    var body: some View {
        VStack() {
            Image(imagem)
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                    
            VStack {
                Text(titulo)
                    .font(.title2)
                    .foregroundColor(.white)
                    //.padding(.vertical, 2)
                    .padding(.top, 16)
                
                Text(descricao)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
            }
            .padding()
        }
        .frame(width: 260, height: 440, alignment: .center)
        .background(cor)
        .clipShape(Capsule())
        .contentShape(Capsule())
    }
}
