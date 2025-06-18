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
    
    var body: some View {
        ScrollView{
            VStack(){
                ContainerEnunciadoView(enunciado: enunciado).padding()
                
                Divider()
                
                RespostaCard(image: $image, respostaTexto: $respostaTexto)
                Spacer()
            }
        }
        HStack{
            Spacer()
            Button(action: {
                self.showImagePicker = true
            }, label: {
                Label("", systemImage: "photo.on.rectangle")
            })
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $image)
                }
        }
    }
}

