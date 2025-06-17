//
//  QuestaoDesafios.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 13/06/25.
//

import Foundation

struct QuestaoDesafios: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case enunciado
        case conteudo
        case tipo
        case feita
    }
    
    let id: Int
    let enunciado: String
    let conteudo: String
    let tipo: String
    var feita: Bool
    
    
}
