//
//  MaieuticaTelaInicio.swift
//  AppStatecraft
//
//  Created by Aluno 24 on 25/06/25.
//

import SwiftUI

struct MaieuticaTelaInicio: View {
    
    @State private var abrirMaieuticaSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(spacing: 4){
                
                // Aqui pode adicionar a logica de voltar para as metodologias legal
                Image(systemName: "chevron.left")
                    .foregroundColor(.purple)
                Text("Metodologias")
                    .foregroundColor(.purple)
                    .font(.body)
            }
            .padding(.top)
            .padding(.horizontal, 10)
            
            Text("Maiêutica")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.horizontal, 22)
            
            HStack{
                HStack{
                    Image(systemName: "tray.full")
                        .foregroundColor(.purple)
                    
                    Text("Historico")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("0")
                    .foregroundColor(.primary)
                Image(systemName: "chevron.right") 
                    .foregroundColor(.purple)
            }
            .padding(.vertical)
            .padding(.horizontal, 10)
            .background(Color.white.opacity(0.5))
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6){
                Text("Responda as perguntas geradas com base na sua própria ideia!")
                    .font(.body)
                
                Text("O limite máximo de perguntas são dez.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 8)
            .padding(.horizontal)
            
            Spacer()
            
            Button("Começar") {
                abrirMaieuticaSheet.toggle()
            }
            .sheet(isPresented: $abrirMaieuticaSheet) {
                MaieuticaIdeiasView()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical)
        }
    }
}


struct MaieuticaTelaInicio_Previews: PreviewProvider {
    static var previews: some View {
        MaieuticaTelaInicio()
    }
}
