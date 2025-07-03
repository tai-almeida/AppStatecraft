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
    
    func salvarProjetoVazio(contexto: NSManagedObjectContext, projeto: Projeto) {
        do {
            try contexto.save()
            print("salvou")
        } catch {
            print("erro")
        }
    }
    
    
}
