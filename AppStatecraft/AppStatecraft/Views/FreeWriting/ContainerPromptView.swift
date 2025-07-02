//
//  ContainerPromptView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 25/06/25.
//

import SwiftUI

struct ContainerPromptView: View {
    var enunciado: String
    
    var body: some View {
        VStack{
            Text(enunciado)
                .foregroundColor(.black)
                .padding(.vertical)
                .padding(.horizontal, 10)
                
            
        }
        .background( //coloca view atras da view atual
            //view que sera colocada atras é o retangulo
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
    }
}
