//
//  InicialDesafiosView.swift
//
//  Created by Aluno 07 on 17/06/25.
//

import SwiftUI

struct InicialDMView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            ScrollView {
                NavigationLink(destination: Text("Conteudo historico") .navigationTitle("Histórico")) {
                HStack(alignment: .top) {
                    Image(systemName: "tray")
                        .foregroundColor(Color.accentColor)
                    
                    Text("Histórico")
                        .foregroundColor(.primary)
                        
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(.tertiaryLabel))
                        
                    }
                    
                .padding(.horizontal)
                
                }
            Divider()
            Text("Crie uma nova obra de arte a partir de outra e explore sua criatividade!")
            Spacer()
            }
            Button("Começar") {
                showingSheet.toggle()
            }
            .fullScreenCover(isPresented: $showingSheet) {
                DesafiosMultimidiaView()
                .accentColor(Color("AccentColor"))
                .interactiveDismissDisabled() // impede o gesto de deslizar
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical)
        }
        .navigationTitle("Desafios Multimídia")
    }
}

struct InicialDesafiosView_Previews: PreviewProvider {
    static var previews: some View {
        InicialDMView()
    }
}
