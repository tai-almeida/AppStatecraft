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
    
    
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    @State private var respostaTexto: String = ""
    @StateObject private var desafiosVM = DesafiosMultimidiaViewModel()
    @State private var desafio: QuestaoDesafios?
    @State private var isShowingDialog = false
    @State private var isShowingAddProjetos = false
    
    
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
                                }
                                .foregroundColor(.accentColor)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("OK") {
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
//                                        desafiosVM.salvarSemProjeto(
//                                            contexto: viewContext,
//                                            respostaTexto: respostaTexto,
//                                            respostaImagem: image,
//                                            desafio: desafio
                                     //   )  LEMBRAR DE ARRUMAR ISSO DEPOIS
                                        //TODO: logica de permanencia dos dados sinistra
                                        //criar o "objeto"
                                        //navegar para o modal de adicionar a projeto
                                        //salvar o objeto no coredata quando a pessoa clicar no projeto
                                        
                                        self.respostaTexto = ""
                                        self.image = nil
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
                            }
                        }//por enquanto vou salvar sem projeto para testar o mecanismo -sofi
//                        .fullScreenCover(isPresented: $isShowingAddProjetos) {
//                            //view de addProjeto
//                            if let desafio = desafio{
//                                AddProjetoView(
//                                    respostaTexto: respostaTexto,
//                                    respostaFoto: image,
//                                    desafio: desafio)
//                            }else{
//                                //tratar se for nil
//                            }
                        //}
                }
            }.onAppear{
                self.desafio = desafiosVM.sorteiaDesafio()
            }
            .fullScreenCover(isPresented: $isShowingAddProjetos) {
                            AddProjetoView(respostaTexto:respostaTexto, respostaFoto: image,
                                           desafio:desafio!)
            }
        }
        .foregroundColor(.primary)
    }
}

