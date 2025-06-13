//
//  DesafioMultimidia.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 12/06/25.
//

import Foundation
import SwiftUI

class DesafioMultimidia: Metodologia{
    let descricaoMultimidia: String
    let respostaUsuario: [String]
    let desafio: Desafio
    
    init(
        descricaoMultimidia: String,
        respostaUsuario: [String],
        desafio: Desafio,
        
        id: UUID,
        nome: String,
        descricao: String,
        cor: Color,
        imagem: String,
        data: Date
    ) {
        self.descricaoMultimidia = descricaoMultimidia
        self.respostaUsuario = respostaUsuario
        self.desafio = desafio
        
        super.init(id: id, nome: nome, descricao: descricao, cor: cor, imagem: imagem, data: data)
    }
}
