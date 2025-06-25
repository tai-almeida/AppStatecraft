//
//  SessaoDesafioMult+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 25/06/25.
//
//

import Foundation
import CoreData


extension SessaoDesafioMult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessaoDesafioMult> {
        return NSFetchRequest<SessaoDesafioMult>(entityName: "SessaoDesafioMult")
    }

    @NSManaged public var enunciado: String?
    @NSManaged public var mediaFoto: Data?
    @NSManaged public var mediaTexto: String?
    @NSManaged public var respostaFoto: Data?
    @NSManaged public var respostaTexto: String?

}
