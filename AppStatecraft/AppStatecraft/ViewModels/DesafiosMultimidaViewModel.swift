//
//  DesafiosMultimidaViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 45 on 13/06/25.
//

import Foundation
import SwiftUI

class DesafiosMultimidiaViewModel: ObservableObject {
    
    @Published var desafiosFeitos = [QuestaoDesafios]()
    @Published var desafiosNaoFeitos = [QuestaoDesafios]()
    
    var desafiosUtilities = DesafiosUtilities()
    
    init() {
        carregaDados()
    }
    
    func carregaDados() {
        desafiosUtilities.carregaDesafios()
        
        desafiosFeitos = desafiosUtilities.desafiosFeitos
        desafiosNaoFeitos = desafiosUtilities.desafiosNaoFeitos
        
        verificaDesafiosVazios()
        
    }
    
    func verificaDesafiosVazios() {
        if desafiosNaoFeitos.isEmpty {
            for desafio in desafiosFeitos {
                var copiaDesafio = desafio
                copiaDesafio.feita = false
                desafiosNaoFeitos.append(copiaDesafio)
            }
            desafiosFeitos.removeAll()
        } else {
            return
        }
    }
    
    func desafioConcluido(desafioRealizado: QuestaoDesafios) {
        var copiaDesafio: QuestaoDesafios = desafioRealizado
        var counter = 0
        for desafio in desafiosNaoFeitos {
            
            if desafio.id == desafioRealizado.id {
                copiaDesafio.feita = true
                desafiosNaoFeitos.remove(at: desafio.id)
                
                for _ in desafiosFeitos {
                    counter = counter + 1
                }
                copiaDesafio.id = counter
                desafiosFeitos.append(copiaDesafio)
            }
        }
    }
    
    func sorteiaDesafio() -> QuestaoDesafios {
        /* Sorteia um desafio dentre os nao feitos para o usuario fazer */
        
        verificaDesafiosVazios()
        
        return desafiosNaoFeitos.randomElement()!
    }
}

