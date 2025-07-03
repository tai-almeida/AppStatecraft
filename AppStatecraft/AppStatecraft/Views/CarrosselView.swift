//
//  CarrosselView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 18/06/25.
//

import SwiftUI

struct CarrosselView: View {
    //guardr indice da pagina ativa
    @State var paginaAtual = 0
    
    let cards = [
        CardView(cor: Color(hex: 0xA0158B), imagem: "Maieutica", titulo: "Maiêutica", descricao: "Descreva sua ideia e responda perguntas sobre ela, como em um diálogo com Sócrates", destino: AnyView(InicialMaieuticaView())),
        CardView(cor: Color(hex: 0x19615b), imagem: "Desafios Multimidia", titulo: "Desafios Multimídia", descricao: "Crie produções com base em outras obras, explorando as diversas formas de arte", destino: AnyView(InicialDMView())),
        CardView(cor: Color(hex: 0x3b36a0), imagem: "Free-Writing", titulo: "Free-Writing", descricao: "Escreva textos criativos a partir de um desafio dado, sem restrições", destino: AnyView(InicialFreeWritingView())),
        CardView(cor: Color(hex: 0x377a95), imagem: "Ping-Pong", titulo: "Ping-Pong", descricao: "A partir de uma palavra, escreva todas que vierem à mente em pouco tempo, sem parar", destino: AnyView(InicialPingPongView()))
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $paginaAtual) {
                // itera pelos indices dos cards (0 a 3)
                ForEach(0..<4) { index in
                    NavigationLink(destination: cards[index].destino) {
                        cards[index]
                    }
                    .tag(index)
                }
                
            }
            .tabViewStyle(.page)
            PageControlView(numeroPaginas: 4, paginaAtual: $paginaAtual)
                .frame(alignment: .center)
                .padding(.bottom, 52)
            
        }
    }
}
