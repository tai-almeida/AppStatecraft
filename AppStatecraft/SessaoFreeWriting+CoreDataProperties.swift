//
//  SessaoFreeWriting+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 12/08/25.
//
//

import Foundation
import CoreData


extension SessaoFreeWriting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessaoFreeWriting> {
        return NSFetchRequest<SessaoFreeWriting>(entityName: "SessaoFreeWriting")
    }

    @NSManaged public var enunciado: String?
    @NSManaged public var resposta: String?

}
