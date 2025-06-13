//
//  DataController.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 13/06/25.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "AppStatecraft")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data falhou em carregar: \(error.localizedDescription)")
            }
        }
    }
}
