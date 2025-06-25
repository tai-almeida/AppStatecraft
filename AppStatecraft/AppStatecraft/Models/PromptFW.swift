//
//  PromptFW.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 25/06/25.
//

import Foundation

struct PromptFW: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case enunciado
        case feita
    }
    
    let id: Int
    let enunciado: String
    var feita: Bool
}
