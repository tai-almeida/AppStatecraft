//
//  Metodologia.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 11/06/25.
//

import Foundation
import SwiftUI

class Metologia{
    
    let id: UUID
    let nome: String
    let descricao: String
    let cor: Color
    let imagem: String
    let data: Date
    
    init(id: UUID = UUID(), nome: String, descricao: String, cor: Color, imagem: String, data: Date) {
        self.id = id
        self.nome = nome
        self.descricao = descricao
        self.cor = cor
        self.imagem = imagem
        self.data = data
    }
    
}
