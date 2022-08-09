//
//  BabyEntity+CoreDataProperties.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro on 09/08/22.
//
//

import Foundation
import CoreData


extension BabyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BabyEntity> {
        return NSFetchRequest<BabyEntity>(entityName: "BabyEntity")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var name: String?
    @NSManaged public var gender: Bool

}

extension BabyEntity : Identifiable {

}
