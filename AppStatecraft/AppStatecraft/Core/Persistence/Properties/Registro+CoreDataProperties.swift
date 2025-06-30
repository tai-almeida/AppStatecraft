//
//  Registro+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 27/06/25.
//
//

import Foundation
import CoreData


extension Registro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Registro> {
        return NSFetchRequest<Registro>(entityName: "Registro")
    }

    @NSManaged public var data: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var titulo: String?
    @NSManaged public var projeto: Projeto?

}

extension Registro : Identifiable {

}
