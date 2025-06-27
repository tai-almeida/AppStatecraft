//
//  FreeWritingView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 25/06/25.
//

import SwiftUI

struct FreeWritingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var respostaTexto: String = ""
    @StateObject private var viewModel = FreeWritingViewModel()
    @State private var prompt: PromptFW?
    let minutos: Int
    let segundos: Int
    @StateObject var timerVM: TimerViewModel = TimerViewModel(minutos: 0, segundos: 0)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(timerVM.tempoFormatado)
                    .font(.title2)
                    .foregroundColor(.black)
                ScrollView{
                    if let prompt = prompt{
                        ContainerPromptView(prompt: prompt).padding()
                    }else{
                        Text("Erro ao carregar prompt")
                    }
                    Divider()
                    RespostaFW(respostaTexto: $respostaTexto).foregroundColor(.primary)
                        .disabled(!timerVM.sendoFeito)
                }
                
                HStack{
                    Spacer()
                    
                        .navigationTitle("Free-Writing")
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
            }
            .onAppear{
                self.prompt = viewModel.sorteiaPrompt()
            }
        }
        .onAppear {
            timerVM.resetar(minutos:minutos, segundos: segundos)
            timerVM.comecaContagem()
        }
    }
}
