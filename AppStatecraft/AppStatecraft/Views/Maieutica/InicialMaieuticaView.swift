//
//  MaieuticaTelaInicio.swift
//  AppStatecraft
//
//  Created by Aluno 24 on 25/06/25.
//

import SwiftUI

struct InicialMaieuticaView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                    .padding(2)
                NavigationLink(destination: HistoricoView(tipoMetodologia: "maieutica") .navigationTitle("Histórico")) {
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
                
            Text("Responda até 10 perguntas sobre seu projeto! Você pode finalizar a sessão quando quiser.")
                    .padding(.horizontal)
            Spacer()
            /*Text("O limite do número de perguntas é 10.")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.padding(.horizontal)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            */
            Spacer()
            }
            Button(action: { showingSheet.toggle() }) {
                Text("Começar")
                    .frame(maxWidth: .infinity)
                    .clipShape(Capsule())
            }
            .fullScreenCover(isPresented: $showingSheet) {
                MaieuticaView()
                    .accentColor(Color("AccentColor"))
                    .interactiveDismissDisabled()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical)
        }
        .navigationTitle("Maiêutica")
    }
}


struct InicialMaieuticaView_Previews: PreviewProvider {
    static var previews: some View {
        InicialMaieuticaView()
    }
}
