//
//  Sessao+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 25/06/25.
//
//

import Foundation
import CoreData


extension Sessao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sessao> {
        return NSFetchRequest<Sessao>(entityName: "Sessao")
    }

    @NSManaged public var data: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var projeto: Projeto?

}

extension Sessao : Identifiable {

}
