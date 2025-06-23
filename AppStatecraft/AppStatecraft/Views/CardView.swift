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
                .frame(height: 300)
                    
            VStack {
                Text(titulo)
                    .font(.title2)
                    .foregroundColor(.white)
                    //.padding(.vertical, 2)
                    .padding(.top, 20)
                
                Text(descricao)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
            .padding()
        }
        .frame(width: 300, height: 520, alignment: .center)
        .background(cor)
        .clipShape(Capsule())
        .contentShape(Capsule())
        
    }
}
