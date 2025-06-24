//
//  DesafiosMultimidiaView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 17/06/25.
//

import SwiftUI
import PhotosUI

struct DesafiosMultimidiaView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    @State private var respostaTexto: String = ""
    @StateObject private var desafiosVM = DesafiosMultimidiaViewModel()
    @State private var desafio: QuestaoDesafios?
    
    
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
                                    dismiss()
                                }
                                .foregroundColor(.accentColor)
                            }
                        }
                }
            }.onAppear{
                self.desafio = desafiosVM.sorteiaDesafio()
            }
        }
        .foregroundColor(.primary)
    }
}
