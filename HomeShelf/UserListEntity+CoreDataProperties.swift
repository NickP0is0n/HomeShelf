//
//  UserListEntity+CoreDataProperties.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//
//

import Foundation
import CoreData


extension UserListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserListEntity> {
        return NSFetchRequest<UserListEntity>(entityName: "UserListEntity")
    }

    @NSManaged public var listName: String

}

extension UserListEntity : Identifiable {

}
