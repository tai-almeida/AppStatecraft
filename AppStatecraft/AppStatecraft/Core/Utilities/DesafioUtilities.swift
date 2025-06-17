//
//  DesafiosUtilities.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 13/06/25.
//

import Foundation
import SwiftUI

class DesafioUtilities: ObservableObject {
    
    @Published var todosDesafios = [QuestaoDesafios]()
    @Published var desafiosFeitos = [QuestaoDesafios]()
    @Published var desafiosNaoFeitos = [QuestaoDesafios]()

    
    init() {
        carregaDesafios()
    }
    
    func carregaDesafios() {
        
        // pega url do arquivo json
        guard let url = Bundle.main.url(forResource: "BancoQuestoes", withExtension: "json") else {
            print("json file not found")
            return
        }
        
        do {
            // descarrega os dados decodificados
            let data = try Data(contentsOf: url)
            let decodedDesafios = try JSONDecoder().decode([QuestaoDesafios].self, from: data)
            
            
            DispatchQueue.main.async {
                self.todosDesafios = decodedDesafios
                self.desafiosFeitos = self.todosDesafios.filter { $0.feita }
                self.desafiosNaoFeitos = self.todosDesafios.filter { !$0.feita }
            }
            
        }catch {
            print("erro")
        }
        
        
        
    }
    
    func decodeQuestao(_ file: String) {
        // TODO: decodificar json para carregar em array
    }
}
