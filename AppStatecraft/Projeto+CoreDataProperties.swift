//
//  Projeto+CoreDataProperties.swift
//  AppStatecraft
//
//  Created by Sofia Villas Bôas on 12/08/25.
//
//

import Foundation
import CoreData


extension Projeto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Projeto> {
        return NSFetchRequest<Projeto>(entityName: "Projeto")
    }

    @NSManaged public var data: Date?
    @NSManaged public var finalizado: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var imagemCapa: Data?
    @NSManaged public var nome: String?
    @NSManaged public var registros: NSSet?
    @NSManaged public var sessoes: NSSet?

}

// MARK: Generated accessors for registros
extension Projeto {

    @objc(addRegistrosObject:)
    @NSManaged public func addToRegistros(_ value: Registro)

    @objc(removeRegistrosObject:)
    @NSManaged public func removeFromRegistros(_ value: Registro)

    @objc(addRegistros:)
    @NSManaged public func addToRegistros(_ values: NSSet)

    @objc(removeRegistros:)
    @NSManaged public func removeFromRegistros(_ values: NSSet)

}

// MARK: Generated accessors for sessoes
extension Projeto {

    @objc(addSessoesObject:)
    @NSManaged public func addToSessoes(_ value: Sessao)

    @objc(removeSessoesObject:)
    @NSManaged public func removeFromSessoes(_ value: Sessao)

    @objc(addSessoes:)
    @NSManaged public func addToSessoes(_ values: NSSet)

    @objc(removeSessoes:)
    @NSManaged public func removeFromSessoes(_ values: NSSet)

}

extension Projeto : Identifiable {

}
