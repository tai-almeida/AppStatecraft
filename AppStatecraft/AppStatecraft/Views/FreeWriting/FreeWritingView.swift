//
//  FreeWritingView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 25/06/25.
//

import SwiftUI
import CoreData

struct FreeWritingView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var contexto
    
    @StateObject private var freewritingVM = FreeWritingViewModel()
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
                        ContainerPromptView(enunciado: prompt.enunciado).padding()
                    }else{
                        Text("Erro ao carregar prompt")
                    }
                    Divider()
                    RespostaFW(respostaTexto: $freewritingVM.respostaTexto).foregroundColor(.primary)
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
                                Button("Finalizar") {
                                    freewritingVM.isShowingDialog = true
                                }
                                .foregroundColor(.accentColor)
                                .confirmationDialog(
                                    "Tem certeza que finalizou?",
                                    isPresented: $freewritingVM.isShowingDialog,
                                    titleVisibility: .hidden
                                ) {
                                    Button("Adicionar a Projeto") {
                                        //self.isShowingAddProjetos = true
                                        //dps associamos a projeto
                                        //TODO: logica de permanencia dos dados sinistra (associar a projeto)
                                        if let prompt = prompt{
                                            freewritingVM.salvarSemProjeto(
                                                contexto: contexto,
                                                respostaTexto: freewritingVM.respostaTexto,
                                                prompt: prompt.enunciado)
                                        }
                                        
                                        freewritingVM.respostaTexto = ""
                                        dismiss()
                                    }
                                    Button("Salvar em Esboços") {
                                        //TODO: logica de permanencia dos dados, so que salvar no esbocos tomee
                                        freewritingVM.isShowingDialog = false
                                        
                                    }
                                    Button("Descartar", role: .destructive) {
                                        dismiss()
                                    }
                                    Button("Continuar Editando", role: .cancel) {
                                        freewritingVM.isShowingDialog = false
                                    }
                                    .foregroundColor(.accentColor)
                                }
                            }
                        }
                }
                .onAppear{
                    self.prompt = freewritingVM.sorteiaPrompt()
                }
            }
            .onChange(of: timerVM.sendoFeito) { checagem in
                if (!checagem) {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    print("deu certo a vibracao")
                }
            }
            .onAppear {
                timerVM.resetar(minutos:minutos, segundos: segundos)
                timerVM.comecaContagem()
            }
        }
    }
}
