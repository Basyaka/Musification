//
//  CDUserInfo+CoreDataProperties.swift
//  Musification
//
//  Created by Vlad Novik on 16.04.21.
//
//

import Foundation
import CoreData


extension CDUserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserInfo> {
        return NSFetchRequest<CDUserInfo>(entityName: "CDUserInfo")
    }

    @NSManaged public var username: String?
    @NSManaged public var userPhoto: Data?

}

extension CDUserInfo : Identifiable {

}
