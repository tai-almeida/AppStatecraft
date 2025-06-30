//
//  SessaoPingPong+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 27/06/25.
//
//

import Foundation
import CoreData


extension SessaoPingPong {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessaoPingPong> {
        return NSFetchRequest<SessaoPingPong>(entityName: "SessaoPingPong")
    }

    @NSManaged public var log: Data?

}
