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
    
    var body: some View {
        Text("Hello World")
    }
}

//
//struct MaieuticaSalvoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MaieuticaSalvoView()
//    }
//}
