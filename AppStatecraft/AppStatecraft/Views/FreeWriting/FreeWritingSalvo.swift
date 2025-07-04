//
//  FreeWritingSalvo.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 30/06/25.
//

import SwiftUI

struct FreeWritingSalvo: View {
    var sessao: SessaoFreeWriting
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(){
                /*HStack {
                    Text("Free-Writing")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Spacer()
                    BotaoCloseModal()
                }.padding()*/
                
                ScrollView{
                    ContainerPromptView(enunciado: sessao.enunciado ?? "Vazio").padding()
                    Divider()
                    Text(sessao.resposta ?? "Vazio")
                        .padding()
                        .font(.body)
                }
            }
            .navigationTitle("Free-Writing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fechar") {
                        dismiss()
                    } .foregroundColor(Color.accentColor)
                }
            }
        }
    }
}
//
//struct FreeWritingSalvo_Previews: PreviewProvider {
//    static var previews: some View {
//        FreeWritingSalvo()
//    }
//}
