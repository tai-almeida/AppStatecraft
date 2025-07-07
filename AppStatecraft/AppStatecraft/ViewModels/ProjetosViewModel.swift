//
//  ProjetosViewModel.swift
//  AppStatecraft
//
//  Created by Aluno 07 on 27/06/25.
//

import Foundation
import UIKit
import SwiftUI
import CoreData


class ProjetosViewModel: ObservableObject {
    @Published var projetos: [Projeto] = []
    
    init(){
    }
    
    func criarProjetoVazio(contexto: NSManagedObjectContext, nome: String, foto: UIImage?, projeto: Projeto?) -> Projeto {
        let projetoVazio = Projeto(context: contexto)
        projetoVazio.id = UUID()
        projetoVazio.data = Date()
        projetoVazio.finalizado = false
        projetoVazio.nome = nome
        
        if let foto = foto {
            projetoVazio.imagemCapa = foto.pngData()
        } else {
            projetoVazio.imagemCapa = UIImage(named: "Background")?.pngData()
        }
            
        
        return projetoVazio
    }
    
    func salvar(contexto: NSManagedObjectContext) {
        do {
            try contexto.save()
            print("salvou")
        } catch {
            print("erro")
        }
    }
    
    func getAllProjetos(contexto: NSManagedObjectContext){
        let requisicao = NSFetchRequest<Projeto>(entityName: "Projeto")
        let ordenadorDeData = NSSortDescriptor(keyPath: \Projeto.data, ascending: false) //mais recente para o mais velho
        requisicao.sortDescriptors = [ordenadorDeData]
        
        do {
            projetos = try contexto.fetch(requisicao)
            print("Busca concluída: \(projetos.count) projetos encontradas.")
        } catch let error {
            print("Erro: \(error.localizedDescription)")
        }
    }
    
    func criarProjComSessao(contexto: NSManagedObjectContext, nome: String, foto: UIImage?, sessao: Sessao) -> Projeto {
        let novoProjetoComSessao = Projeto(context: contexto)
        novoProjetoComSessao.id = UUID()
        novoProjetoComSessao.nome = nome
        novoProjetoComSessao.data = Date()
        novoProjetoComSessao.finalizado = false
        
        if let foto = foto {
            novoProjetoComSessao.imagemCapa = foto.pngData()
        } else {
            novoProjetoComSessao.imagemCapa = UIImage(named: "Background")?.pngData()
        }
        
        novoProjetoComSessao.addToSessoes(sessao)
        
        return novoProjetoComSessao
    }
    
}
