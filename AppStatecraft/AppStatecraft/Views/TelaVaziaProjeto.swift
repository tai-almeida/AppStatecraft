//
//  TelaVaziaProjeto.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 07/07/25.
//

import SwiftUI

struct TelaVaziaProjeto: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            Text("Nenhum projeto encontrado")
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

struct TelaVaziaProjeto_Previews: PreviewProvider {
    static var previews: some View {
        TelaVaziaProjeto()
    }
}
