//
//  MaieuticaSalvoView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 30/06/25.
//

import SwiftUI

struct MaieuticaSalvoView: View {
    @Environment(\.dismiss) var dismiss
    @State var sessao: SessaoMaieutica
    
    var body: some View {
        HStack {
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
            
            EtapasSalvasView(sessao: sessao)
                .padding()
        }
    }
}

struct EtapasSalvasView: View {
    @State var sessao: SessaoMaieutica
    @State var cliqueButton: Int = 0
    @State var indiceAtual = 0
    
    var body: some View {
        
        if let logData = sessao.log,
       let historico = try? JSONDecoder().decode([PromptResposta].self, from: logData),
       !historico.isEmpty {
            
//            let historicoArray = Array(historico)
            let historicoOrdenado = historico.sorted { $0.index < $1.index }
            
            let prompt = historicoOrdenado[indiceAtual].pergunta
            let resposta = historicoOrdenado[indiceAtual].resposta
            
            NavigationView {
                VStack {
                    Text(prompt)
                        .foregroundColor(.black)
                        .font(.title3)
                    
                    Divider()

                    Text(resposta)
                        .font(.body)
                        .padding(8)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityHidden(true)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding()
            }
            
            Button(action: {
                if indiceAtual < historicoOrdenado.count - 1 {
                    indiceAtual += 1
                }
            }) {
                Text("Seguinte")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .padding(.vertical)

            }
            .disabled(indiceAtual == historicoOrdenado.count - 1)
        }
    }
}

//
//struct MaieuticaSalvoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MaieuticaSalvoView()
//    }
//}
