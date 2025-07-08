//
//  HistoricoDesafiosViewModel.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 25/06/25.
//

import SwiftUI
import CoreData

class HistoricoViewModel: ObservableObject {
    @Published var sessoes: [Sessao] = []
    
    init(){
    }
    
    //busca no banco os desafios salvos de determinado tipo
    func fetchSessoesFeitas(contexto: NSManagedObjectContext, tipo: String){
        let (requisicao, ordenadorDeData) = getRequisicaoCerta(tipo)
        requisicao.sortDescriptors = [ordenadorDeData]
        
        do {
            sessoes = try contexto.fetch(requisicao)
            print("Busca concluída: \(sessoes.count) sessões do tipo '\(tipo)' encontradas.")
        } catch let error {
            print("Erro ao buscar sessões do tipo '\(tipo)': \(error.localizedDescription)")
        }
    }
    
    //centraliza as requisicoes para cada tipo de metodologia do app
    private func getRequisicaoCerta(_ tipo: String) -> (requisicao: NSFetchRequest<Sessao>, ordenador: NSSortDescriptor){
        let requisicao: NSFetchRequest<Sessao>
        let ordenadorDeData: NSSortDescriptor
        
        switch tipo {
        case "maieutica":
            requisicao = NSFetchRequest<Sessao>(entityName: "SessaoMaieutica")
            ordenadorDeData = NSSortDescriptor(keyPath: \SessaoMaieutica.data, ascending: false) //quero da mais nova para mais antiga
        case "multimidia":
            requisicao = NSFetchRequest<Sessao>(entityName: "SessaoDesafioMult")
            ordenadorDeData = NSSortDescriptor(keyPath: \SessaoDesafioMult.data, ascending: false)
        case "freewriting":
            requisicao = NSFetchRequest<Sessao>(entityName: "SessaoFreeWriting")
            ordenadorDeData = NSSortDescriptor(keyPath: \SessaoFreeWriting.data, ascending: false)
        case "pingpong":
            requisicao = NSFetchRequest<Sessao>(entityName: "SessaoPingPong")
            ordenadorDeData = NSSortDescriptor(keyPath: \SessaoPingPong.data, ascending: false)
        default:
            requisicao = NSFetchRequest<Sessao>(entityName: "Sessao")
            ordenadorDeData = NSSortDescriptor(keyPath: \Sessao.data, ascending: false)  //pega todas, nao sabia o que por aqui
        }
        return (requisicao, ordenadorDeData)
    }
}


