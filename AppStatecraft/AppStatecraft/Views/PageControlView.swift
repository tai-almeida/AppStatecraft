//
//  PageControlView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 18/06/25.
//

import SwiftUI

struct PageControlView: View {
    
    var numeroPaginas: Int
    
    @Binding var paginaAtual: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numeroPaginas) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(index == self.paginaAtual ? .accentColor : .gray)
                    .onTapGesture(perform: { self.paginaAtual = index })
            }
        }
    }
}
