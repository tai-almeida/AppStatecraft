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
    @Binding var ehIndividual: Bool
    @State var estaProcessando: Bool = false
    @State var acabouTempo: Bool = false
    @State var sessao: SessaoPingPong? = nil

    
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
                                if (index == palavras.count - 1) {
                                    VStack {
                                        ZStack {
                                            Image("CaixinhaPingPong")
                                            Text(palavra)
                                                .foregroundColor(.black)
                                        }
                                        Image("LinhaPingPong")
                                    }
                                    .id("ultimaCaixa")
                                }
                                else {
                                    VStack {
                                        ZStack {
                                            Image("CaixinhaPingPong")
                                            Text(palavra)
                                                .foregroundColor(.black)
                                        }
                                        Image("LinhaPingPong")
                                    }
                                }
                            }
                            if (!estaProcessando) {
                                ZStack {
                                    Image("CaixinhaPingPong")
                                    TextField("Escreva", text: $input)
                                        .onSubmit{
                                            palavras.append(input)
                                            input = ""
                                            if (!ehIndividual) {
                                                Task {
                                                    estaProcessando = true
                                                    let palavraNova = await pingpongVM.continuarPingPong(context: palavras)
                                                    palavras.append(palavraNova ?? "Erro")
                                                    estaProcessando = false
                                                }
                                            }
                                        }
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black)
                                        .disabled(!timerVM.sendoFeito)
                                    
                                }
                                .id("textField")
                            }
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
                                sessao = pingpongVM.criarSessao(contexto: viewContext, palavras: palavras)
                                self.isShowingAddProjetos = true
                                self.palavras = []
                                dismiss()
                            }
                            Button("Salvar em Esboços") {
                                sessao = pingpongVM.criarSessao(contexto: viewContext, palavras: palavras)
                                pingpongVM.salvarContexto(contexto: viewContext)
                                dismiss()
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
    .fullScreenCover(isPresented: $isShowingAddProjetos) {
        AddProjetoView(sessao: sessao)
    }
    .onChange(of: timerVM.sendoFeito) { checagem in
        if (!checagem) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            acabouTempo = true
            //print("deu certo a vibracao")
        }
    }
    .onAppear {
        timerVM.resetar(minutos:minutos, segundos: segundos)
        timerVM.comecaContagem()
    }
    .alert("Acabou o tempo!", isPresented: $acabouTempo) {
        Button("Entendi", role: .cancel) {}
    } message: {
        Text("O tempo da atividade se esgotou. Agora, finalize a sessão.")
    }
        
    }
}


