//
//  HistoricoDesafiosViewModel.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 25/06/25.
//

import SwiftUI
import CoreData

class HistoricoDesafiosViewModel: ObservableObject {
    @Published var sessoesMultimidia: [SessaoDesafioMult] = []
    
    init(){
    }
    
    //busca no banco os desafios salvos
    func fetchDesafiosFeitos(contexto: NSManagedObjectContext){
        let requisicao = NSFetchRequest<SessaoDesafioMult>(entityName: "SessaoDesafioMult")
        let ordenadorDeData = NSSortDescriptor(keyPath: \SessaoDesafioMult.data, ascending: false) //quero da mais nova para mais antiga
        requisicao.sortDescriptors = [ordenadorDeData]
        
        do {
            sessoesMultimidia = try contexto.fetch(requisicao)
        } catch let error {
            print("Erro buscando sessoes desafio multimidia: \(error)")
        }
    }
}


