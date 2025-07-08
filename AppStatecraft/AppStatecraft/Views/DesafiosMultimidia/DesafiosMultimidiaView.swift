//
//  DesafiosMultimidiaView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 17/06/25.
//

import SwiftUI
import PhotosUI
import CoreData

struct DesafiosMultimidiaView: View {
    //vamo refatorar isso dps slk
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var metodologiaAparecendo: Bool
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    @State private var respostaTexto: String = ""
    @StateObject private var desafiosVM = DesafiosMultimidiaViewModel()
    @State private var desafio: QuestaoDesafios?
    @State private var isShowingDialog = false
    @State private var isShowingAddProjetos = false
    @State private var sessaoDesafios: SessaoDesafioMult? = nil
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    if let desafio = desafio{
                        ContainerEnunciadoView(desafio: desafio).padding()
                    }else{
                        Text("Erro ao carregar desafio")
                    }
                    Divider()
                    RespostaCard(image: $image, respostaTexto: $respostaTexto).foregroundColor(.primary)
                }
                HStack{
                    Spacer()
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        Label("", systemImage: "photo.on.rectangle")
                    })
                        .padding()
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(selectedImage: $image)
                        }
                        .foregroundColor(.accentColor)
                        .navigationTitle("Desafio")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancelar") {
                                    dismiss()
                                   // self.metodologiaAparecendo = false
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
                                        sessaoDesafios = desafiosVM.criarSessao(contexto: viewContext, respostaTexto: respostaTexto, respostaImagem: image, desafio: desafio)
                                        self.isShowingAddProjetos = true
                                        self.respostaTexto = ""
                                        self.image = nil
                                    }
                                    
                                    Button("Salvar no Histórico") {
                                        sessaoDesafios = desafiosVM.criarSessao(contexto: viewContext, respostaTexto: respostaTexto, respostaImagem: image, desafio: desafio)
                                        desafiosVM.salvarContexto(contexto: viewContext) //isso aqui vai sari daqui
                                        self.respostaTexto = ""
                                        self.image = nil
                                        self.desafiosVM.desafioConcluido(desafioRealizado: desafio!)
                                        self.desafiosVM.atualizaJson()
                                        dismiss()
                                    }
                                    Button("Descartar", role: .destructive) {
                                        dismiss()
                                    }
                                    Button("Continuar Editando", role: .cancel) {
                                        isShowingDialog = false
                                    }
                                }
                            }
                        }
                }
            
            }.onAppear{
                //self.desafiosVM.copiaJson()
                self.desafiosVM.carregaDesafios()
                self.desafiosVM.verificaDesafiosVazios()
                self.desafio = desafiosVM.sorteiaDesafio()
            }
            .fullScreenCover(isPresented: $isShowingAddProjetos) {
                AddProjetoView(metodologiaAparecendo: $metodologiaAparecendo, sessao: sessaoDesafios, desafio: desafio, prompt: nil)
            }
        }
        .foregroundColor(.primary)
    }
}
