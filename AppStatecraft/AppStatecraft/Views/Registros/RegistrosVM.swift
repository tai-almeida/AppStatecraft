//
//  RegistrosVM.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 12/08/25.
//

import Foundation
import SwiftUI
import CoreData


class RegistrosVM: ObservableObject {
    @Published var registros: [Registro] = []
    private var contexto: NSManagedObjectContext
    
    init(contexto: NSManagedObjectContext) {
        self.contexto = contexto
        readRegistros()
    }
    
    func readRegistros() {
        let requisicao = NSFetchRequest<Registro>(entityName: "Registro")
        requisicao.sortDescriptors = [NSSortDescriptor(keyPath: \Registro.data, ascending: false)]
        
        do {
            self.registros = try contexto.fetch(requisicao)
            
        } catch let error {
            print("Error fetching results \(error)")
        }
    }
    
    func addNewRegistro(titulo: String, texto: String) {
        let registro = Registro(context: self.contexto)
        registro.data = Date()
        registro.titulo = titulo
        registro.texto = texto
        registro.id = UUID()
        
        save()
        
        self.registros.insert(registro, at: 0) //inserir na ordem certa
    }
    
    private func save() {
        do {
            try contexto.save()
        } catch let error {
            print("Erro ao salvar o contexto: \(error.localizedDescription)")
        }
    }
}

