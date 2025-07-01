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
    @Environment(\.managedObjectContext) private var viewContext

    let minutos: Int
    let segundos: Int
    @State private var isShowingDialog = false
    @State private var isShowingAddProjetos = false
    @StateObject var pingpongVM: PingPongViewModel = PingPongViewModel()
    
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
                        Button("Finalizar") {
                            isShowingDialog = true
                        } .foregroundColor(.accentColor) // TODO: queria muito tirar esses um milhao foregroundColor!!
                        .confirmationDialog(
                            "Tem certeza que finalizou o desafio?",
                            isPresented: $isShowingDialog,
                            titleVisibility: .hidden
                        ) {
                            Button("Adicionar a Projeto") {
                                self.isShowingAddProjetos = true
                                //dps associamos a projeto
                                pingpongVM.salvarSemProjeto(
                                    contexto: viewContext,
                                    palavras: palavras
                                )
                                //TODO: logica de permanencia dos dados sinistra
                                //criar o "objeto"
                                //navegar para o modal de adicionar a projeto
                                //salvar o objeto no coredata quando a pessoa clicar no projeto
                                
                                self.palavras = []
                                dismiss()
                            }
                            Button("Salvar em Esboços") {
                                //TODO: logica de permanencia dos dados, so que salvar no esbocos tomee
                            }
                            Button("Descartar", role: .destructive) {
                                dismiss()
                            }
                            Button("Continuar Editando", role: .cancel) {
                                isShowingDialog = false
                            }
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


