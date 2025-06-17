//
//  ContentView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 11/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var desafiosManager = DesafiosUtilities()
    
    var body: some View {
        VStack {
            Text("Completed Questions (\(desafiosManager.desafiosFeitos.count))")
            List(desafiosManager.desafiosFeitos) { desafio in
                Text(desafio.enunciado)
                if desafio.tipo == "imagem" {
                    Image(desafio.conteudo)
                } else {
                    Text(desafio.conteudo)
                }
                
            }
            
            Text("Pending Questions (\(desafiosManager.desafiosNaoFeitos.count))")
            List(desafiosManager.desafiosNaoFeitos) { desafio in
                Text(desafio.enunciado)
                if desafio.tipo == "imagem" {
                    Image(desafio.conteudo)
                        .resizable()
                        .scaledToFit()
                        
                } else {
                    Text(desafio.conteudo)
                }
            }
        }
    }
}
