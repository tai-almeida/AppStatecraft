//
//  DesafiosMultimidiaView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 17/06/25.
//

import SwiftUI
import PhotosUI

struct DesafiosMultimidiaView: View {
    var enunciado: String
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    @State private var respostaTexto: String = ""
    @StateObject private var desafiosVM = DesafiosMultimidiaViewModel()
    @State private var desafio: QuestaoDesafios?
    
    
    var body: some View {
        ScrollView{
            VStack(){
                if let desafio = desafio{
                    ContainerEnunciadoView(desafio: desafio).padding()
                }else{
                    Text("Erro ao carregar desafio")
                }
                Divider()
                
                RespostaCard(image: $image, respostaTexto: $respostaTexto)
                Spacer()
            }
        }.onAppear{
            self.desafio = desafiosVM.sorteiaDesafio()
        }
        HStack{
            Spacer()
            Button(action: {
                self.showImagePicker = true
            }, label: {
                Label("", systemImage: "photo.on.rectangle").font(.title2)
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $image)
            }
        }
    }
}

