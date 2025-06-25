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
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    if let prompt = prompt{
                        ContainerPromptView(prompt: prompt).padding()
                    }else{
                        Text("Erro ao carregar prompt")
                    }
                    Divider()
                    RespostaFW(respostaTexto: $respostaTexto).foregroundColor(.primary)
                }
                
                HStack{
                    Spacer()
//                    Button(action: {
//                        self.showImagePicker = true
//                    }, label: {
//                        Label("", systemImage: "photo.on.rectangle")
//                    })
//                        .padding()
//                        .sheet(isPresented: $showImagePicker) {
//                            ImagePicker(selectedImage: $image)
//                        }
//                        .foregroundColor(.accentColor)
                    
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
//        .foregroundColor(.primary)
    }
}
