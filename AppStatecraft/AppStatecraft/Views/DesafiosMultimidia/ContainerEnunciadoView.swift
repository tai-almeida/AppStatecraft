//
//  ContainerEnunciadoView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 17/06/25.
//

import SwiftUI

struct ContainerEnunciadoView: View {    
    var desafio: QuestaoDesafios
    
    var body: some View {
        VStack{
            Text(desafio.enunciado)
                .padding(.top)
                .padding(.horizontal, 10)

            if(desafio.tipo == "imagem"){
                Image(desafio.conteudo)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .padding(.bottom)
            }else{
                Text(desafio.conteudo)
                    .italic()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
            }
        }
        .background( //coloca view atras da view atual
            //view que sera colocada atras é o retangulo
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
        
    }
}
