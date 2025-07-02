//
//  PingPongSalvoView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 30/06/25.
//

import SwiftUI

struct PingPongSalvoView: View {
    @Environment(\.dismiss) var dismiss
    @State var sessao: SessaoPingPong
    
    var body: some View {
        HStack {
            Text("Ping-Pong")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.leading)
            Spacer()
            Button(action: {
                dismiss()
            })  {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.gray)
            }.padding(.top)
                .padding(.trailing)
        }
        
        VStack(alignment: .center) {
            
            PalavrasSalvasView(sessao: sessao)
                .padding()
        }
    }
}

struct PalavrasSalvasView: View {
    @State var sessao: SessaoPingPong
    
    
    var body: some View {
        ScrollView {
            if let logData = sessao.log,
            let palavras = try? JSONDecoder().decode([String].self, from: logData),
            !palavras.isEmpty {
                VStack {
                    ForEach (Array(palavras.enumerated()), id: \.0) { index, palavra in
                        VStack {
                            ZStack {
                                Image("CaixinhaPingPong")
                                Text(palavra)
                                    .foregroundColor(.black)
                            }
                            if index < palavras.count - 1  {
                                Image("LinhaPingPong")
                            }
                        }
                    }
    //                .id("textField")
                }
            }
        }
    }
}

//struct PingPongSalvoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PingPongSalvoView()
//    }
//}
