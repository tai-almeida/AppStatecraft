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
        CardView(cor: .blue, imagem: "homem", titulo: "Free-Writing", descricao: "bla bla bla"),
        CardView(cor: .green, imagem: "homem", titulo: "Free-Writing", descricao: "bla bla bla"),
        CardView(cor: .pink, imagem: "homem", titulo: "Free-Writing", descricao: "bla bla bla"),
        CardView(cor: .cyan, imagem: "homem", titulo: "Free-Writing", descricao: "bla bla bla")
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $paginaAtual) {
                // itera pelos indices dos cards (0 a 3)
                ForEach(0..<4) { index in
                    cards[index]
                        .tag(index)
                }
                
            }
            .tabViewStyle(.page)
            PageControlView(numeroPaginas: 4, paginaAtual: $paginaAtual)
            
        }
    }
}
