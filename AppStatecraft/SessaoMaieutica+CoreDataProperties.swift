//
//  SessaoMaieutica+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 12/08/25.
//
//

import Foundation
import CoreData


extension SessaoMaieutica {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SessaoMaieutica> {
        return NSFetchRequest<SessaoMaieutica>(entityName: "SessaoMaieutica")
    }

    @NSManaged public var log: Data?

}
