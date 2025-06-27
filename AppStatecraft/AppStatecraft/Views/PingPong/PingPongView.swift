//
//  PingPongView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
import UIKit
import AVFoundation
import SwiftUI

struct PingPongView: View {
    //@StateObject var viewModel = PingPongViewModel()
    @Binding var textoIA: String
    @Binding var palavras: [String]
    @State var input = ""
    @Environment(\.dismiss) var dismiss
    @StateObject private var timerVM: TimerViewModel = TimerViewModel(minutos: 0, segundos: 0)
    let minutos: Int
    let segundos: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Text(timerVM.tempoFormatado)
                    .font(.title2)
                    .foregroundColor(.black)
                
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical) {
                        VStack () {

                            ForEach (Array(palavras.enumerated()), id: \.0) { index, palavra in
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
                                TextField("Escreva", text: $input)
                                    .onSubmit{
                                        palavras.append(input)
                                        input = ""
                                    }
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .disabled(!timerVM.sendoFeito)
                                
//                                TextFieldUIKit(texto: $input, onEnter: { novoTexto in
//                                    palavras.append(novoTexto)
//                                })
//                                    .frame(height: 40)
                                //TextField ("Escreva aqui", text: $input)
                                    //.multilineTextAlignment(.center)
                            }
                            .id("textField")
                        }
            
                    }
                    .onChange(of: palavras.count) { _ in
                        withAnimation {
                            scrollProxy.scrollTo("textField", anchor: .bottom)
                        }
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
                        Button("Salvar") {
                            dismiss()
                        }
                        .foregroundColor(.accentColor)
                    }
                }
        }
    }
    .onChange(of: timerVM.sendoFeito) { checagem in
        if (!checagem) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            //print("deu certo a vibracao")
        }
    }
    .onAppear {
        timerVM.resetar(minutos:minutos, segundos: segundos)
        timerVM.comecaContagem()
    }
        
    }
}//struct PingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        PingPongView()
//    }
//}


