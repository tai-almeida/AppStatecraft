//
//  HistoricoDesafiosView.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 25/06/25.
//

import SwiftUI

struct HistoricoDesafiosView: View {
    @Environment(\.managedObjectContext) private var contexto
    @StateObject private var historicoMultVM = HistoricoDesafiosViewModel()
    
    var body: some View {
        List{
            ForEach(historicoMultVM.sessoesMultimidia){ sessao in
                //testes sofi so para ver se tava pegando certo as coisas salvas: spoiler esta!!!!!!!
                Text(sessao.data!, style: .date)
                if let image = sessao.respostaFoto{
                    //converter binary data para imagem aqui
                }else{
                    Text(sessao.respostaTexto!)
                }
            }
        }.onAppear {
            historicoMultVM.fetchDesafiosFeitos(contexto: contexto)
        }
    }
}

