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
    
    var body: some View {
        VStack() {
            Image(imagem)
                //.resizable()
                .scaledToFit()
                .frame(height: 260)
                .clipped()
                //.padding(.top, 20)
            VStack {
                Text(titulo)
                    .foregroundColor(.white)
                
                Text(descricao)
                    .foregroundColor(.white)
            }
            
            
        }
        .padding()
        .frame(width: 300, height: 520, alignment: .center)
        .background(cor)
        .clipShape(Capsule())
        //.clipShape(RoundedRectangle(cornerRadius: 60, style: .continuous))
        
    }
}
