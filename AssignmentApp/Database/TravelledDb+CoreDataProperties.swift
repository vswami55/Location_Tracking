//
//  TravelledDb+CoreDataProperties.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//
//

import Foundation
import CoreData


extension TravelledDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest <TravelledDb> {
        return NSFetchRequest<TravelledDb>(entityName: "TravelledDb")
    }

    @NSManaged public var meters: Int32
    @NSManaged public var dateTime: String?

}

extension TravelledDb : Identifiable {

}
