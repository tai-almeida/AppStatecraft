//
//  PingPongView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

import SwiftUI
import UIKit

struct PingPongView: View {
    @StateObject var viewModel = PingPongViewModel()
    @State var textoIA = ""
    @State var palavras: [String] = []
    @State var input = ""
    var body: some View {
        VStack {
            ForEach (palavras, id: \.self) { palavra in
                Text(palavra)
            }
            TextField ("Escreva aqui", text: $input)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            textoIA = await viewModel.fazerRequisicao(context: []) ?? "Erro"
            palavras.append(textoIA)
        }
    }
}

//struct PingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        PingPongView()
//    }
//}
