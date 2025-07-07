//
//  InicialDesafiosView.swift
//
//  Created by Aluno 07 on 17/06/25.
//

import SwiftUI

struct InicialDMView: View {
    
    @State private var showingSheet = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                    .padding(2)
                NavigationLink(destination: HistoricoView(tipoMetodologia: "multimidia", metodologiaFormatada: "Desafios").navigationTitle("Histórico")) {
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
                .padding(.horizontal)
            Spacer()
            }
            Button(action: { showingSheet.toggle() }) {
                Text("Começar")
                    .frame(maxWidth: .infinity)
                    .clipShape(Capsule())
            }
            .fullScreenCover(isPresented: $showingSheet) {
                DesafiosMultimidiaView(metodologiaAparecendo: $showingSheet)
                .accentColor(Color("AccentColor"))
                .interactiveDismissDisabled() // impede deslizar
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Desafios Multimídia")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button (action: {dismiss()}) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Metodologias")
                    }
                }
            }
        }
    }
}
