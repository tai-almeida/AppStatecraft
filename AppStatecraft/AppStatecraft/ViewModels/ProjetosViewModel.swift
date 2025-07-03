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
        
        if let projeto = projeto {
            projetoVazio.finalizado = false
            
            if projeto.nome == "" {
                
            }
            projetoVazio.nome = projeto.nome
            
            if projeto.imagemCapa == nil {
                let image = UIImage(named: "Background")
                projetoVazio.imagemCapa = image?.pngData()
            } else {
                projetoVazio.imagemCapa = foto?.pngData()
            }
        }
        
        return projetoVazio
    }
    
    func salvarProjetoVazio(contexto: NSManagedObjectContext, projeto: Projeto) {
        do {
            try contexto.save()
            print("salvou")
        } catch {
            print("erro")
        }
    }
}
