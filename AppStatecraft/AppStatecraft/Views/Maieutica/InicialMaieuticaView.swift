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
                
            Text("Responda as perguntas geradas com base na sua própria ideia!")
                    .padding(.horizontal)
            Spacer()
            Text("O limite do número de perguntas é 10")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            Spacer()
            }
            Button("Começar") {
                showingSheet.toggle()
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
