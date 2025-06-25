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
        NavigationView {
            ScrollView(.vertical) {
                VStack () {
                    ForEach (palavras, id: \.self) { palavra in
                        VStack {
                            ZStack {
                                Image("CaixinhaPingPong")
                                Text(palavra)
                            }
                            Image("LinhaPingPong")
                        }
                    }
                    ZStack {
                        Image("CaixinhaPingPong")
                        TextFieldUIKit(texto: $input, onEnter: {novoTexto in
                            palavras.append(novoTexto)
                        })
                            .frame(height: 40)
                        //TextField ("Escreva aqui", text: $input)
                            //.multilineTextAlignment(.center)
                    }
                }
                .frame(alignment: .top)
                .task {
                    if textoIA == "" {
                        var aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                        while aux == "Erro da IA" {
                            aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                        }
                        textoIA = aux
                        palavras.append(textoIA)
                    }
                }
            }
            .padding(0)
        }
        .navigationTitle("Ping-Pong")
        .navigationBarTitleDisplayMode(.large)
        .ignoresSafeArea()
    }
}

//struct PingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        PingPongView()
//    }
//}
