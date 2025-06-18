//
//  ContainerEnunciadoView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 17/06/25.
//

import SwiftUI

struct ContainerEnunciadoView: View {
    var enunciado: String
    
    var body: some View {
        VStack{
            Text(enunciado)
                .padding(.top)
            Image("viajante")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background( //coloca view atras da view atual
            //view que sera colocada atras é o retangulo
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(radius: 1)
        )
    }
}

