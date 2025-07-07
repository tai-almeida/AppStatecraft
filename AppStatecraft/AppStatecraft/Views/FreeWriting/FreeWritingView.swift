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
    @Binding var metodologiaAparecendo: Bool
    let minutos: Int
    let segundos: Int
    @StateObject var timerVM: TimerViewModel = TimerViewModel(minutos: 0, segundos: 0)
    @State var acabouTempo: Bool = false
    @State private var sessao: SessaoFreeWriting? = nil
    @State private var isShowingAddProjetos = false

    
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
                                        guard let prompt = prompt else {
                                            print("Erro: O prompt é nulo. A sessão não pode ser criada.")
                                            return
                                        }
                                        
                                        sessao = freewritingVM.criarSessao(contexto: contexto, resposta: freewritingVM.respostaTexto, prompt: prompt)                                       
                                        self.isShowingAddProjetos = true
                                        freewritingVM.respostaTexto = ""
                                    }
                                    Button("Salvar em Histórico") {
                                        guard let prompt = prompt else {
                                            print("Erro: O prompt é nulo. A sessão não pode ser criada.")
                                            return
                                        }
                                        
                                        sessao = freewritingVM.criarSessao(contexto: contexto, resposta: freewritingVM.respostaTexto, prompt: prompt)
                                        freewritingVM.salvarContexto(contexto: contexto)
                                        freewritingVM.respostaTexto = ""
                                        dismiss()
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
            .fullScreenCover(isPresented: $isShowingAddProjetos) {
                AddProjetoView(metodologiaAparecendo: $metodologiaAparecendo,
                               //addProjAparecendo: $isShowingAddProjetos,
                               sessao: sessao)
            }
            .onChange(of: timerVM.sendoFeito) { checagem in
                if (!checagem) {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    acabouTempo = true
                }
            }
            .onAppear {
                timerVM.resetar(minutos:minutos, segundos: segundos)
                timerVM.comecaContagem()
            }
            .alert("Tempo encerrado!", isPresented: $acabouTempo) {
                Button("Entendi", role: .cancel) {}
            } message: {
                Text("Você concluiu a atividade com sucesso! Agora, finalize a sessão e aproveite seu progresso.")
            }
        }
    }
}
