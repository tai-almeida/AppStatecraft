//
//  MultimidiaSalvoView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 27/06/25.
//

import SwiftUI

struct MultimidiaSalvoView: View {
    @Environment(\.dismiss) var dismiss
    @State var sessao: SessaoDesafioMult
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Spacer()
                BotaoCloseModal()
            }
            EnunciadoSalvoView(sessao: sessao).padding()
            Divider()
            if let data = sessao.respostaFoto, let uiImage = UIImage(data: data) {
                HStack {
                    Spacer() // Espaçador à esquerda
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom)
                    Spacer() // Espaçador à direita
                }
            }else{
                Text(sessao.respostaTexto ?? "vazio")
                    .font(.body)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
            }
            Spacer()
        }
    }
}


struct EnunciadoSalvoView: View {
    @State var sessao: SessaoDesafioMult
    
    var body: some View {
        VStack{
            Text(sessao.enunciado ?? "ta nil")
                .padding(.top)
                .padding(.horizontal, 10)
            
            if let data = sessao.mediaFoto, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .padding(.bottom)
            }else{
                Text(sessao.mediaTexto ?? "vazio")
                    .italic()
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
        
    }
}

//struct MultimidiaSalvoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultimidiaSalvoView()
//    }
//}
