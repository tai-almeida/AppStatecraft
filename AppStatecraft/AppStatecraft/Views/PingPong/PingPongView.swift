//
//  PingPongView.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 24/06/25.
//

import SwiftUI

struct PingPongView: View {
    @StateObject var viewModel = PingPongViewModel()
    @State var textoIA = ""
    var body: some View {
        Text(textoIA)
            .task {
                textoIA = await viewModel.fazerRequisicao(context: []) ?? "Erro"
            }
    }
}

//struct PingPongView_Previews: PreviewProvider {
//    static var previews: some View {
//        PingPongView()
//    }
//}
