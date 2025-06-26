//
//  PingPongView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

import SwiftUI
import UIKit

struct PingPongView: View {
    //@StateObject var viewModel = PingPongViewModel()
    @Binding var textoIA: String
    @Binding var palavras: [String]
    @State var input = ""
    @StateObject private var timerVM: TimerViewModel = TimerViewModel(minutos: 0, segundos: 0)
    
    let minutos: Int
    let segundos: Int
    
    
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack () {
                    Text(timerVM.tempoFormatado)
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    ForEach (palavras, id: \.self) { palavra in
                        VStack {
                            ZStack {
                                Image("CaixinhaPingPong")
                                Text(palavra)
                                    .foregroundColor(.black)
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
                .onAppear {
                    timerVM.resetar(minutos: minutos, segundos: segundos)
                    timerVM.comecaContagem()
                }
            }
            
            .padding()
            .navigationTitle("Ping-Pong")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .foregroundColor(.accentColor)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") {
                        dismiss()
                    }
                    .foregroundColor(.accentColor)
                }
            }
        }
        
                //.frame(alignment: .top)
                /*.task {
                    if textoIA == "" {
                        var aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                        while aux == "Erro da IA" {
                            aux = await viewModel.fazerRequisicao(context: []) ?? "Erro da IA"
                        }
                        textoIA = aux
                        palavras.append(textoIA)
                    }
                }*/
    }
}

//struct PingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        PingPongView()
//    }
//}
