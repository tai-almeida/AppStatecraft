//
//  DetalhesProjetoView.swift
//  AppStatecraft
//
//  Created by Aluno 07 on 26/06/25.
//

import Foundation
import SwiftUI
import CoreData

struct detalhesProjetoView: View {
    var projeto: Projeto
    var body: some View {
        VStack {
            Text("detalhes projeto: \(projeto.nome ?? "")")
            
        }
        
    }
}
