//
//  NewsL+CoreDataProperties.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 11/08/22.
//
//

import Foundation
import CoreData


extension NewsL {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsL> {
        return NSFetchRequest<NewsL>(entityName: "NewsL")
    }

    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionN: String?
    @NSManaged public var published_at: String?
    @NSManaged public var source: String?
    @NSManaged public var url: String?

}

extension NewsL : Identifiable {

}
