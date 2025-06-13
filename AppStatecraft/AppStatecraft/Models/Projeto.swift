//
//  Projeto.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 12/06/25.
//

import Foundation
import SwiftUI

class Projeto{
    let id: UUID
    let nome: String
    let imagem: String
    var metodologias: [Metodologia]
    var finalizado: Bool
    //let registros: [Registro]
    
    init(id: UUID = UUID(), nome: String, imagem: String, metodologias: [Metodologia]) {
        self.id = id
        self.nome = nome
        self.imagem = imagem
        self.metodologias = metodologias
        self.finalizado = false
    }
}

