//
//  ReqProjetos.swift
//  AppStatecraft
//
//  Created by Aluno 07 on 30/06/25.
//

import Foundation
import SwiftUI

struct ReqProjetos: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case data
        case finalizado
        case id
        case imagemCapa
        case nome
    }
    
    let data: Data
    let finalizado: Bool
    let id: Int
    let imagemCapa: String
    let nome: String
    
    
}
