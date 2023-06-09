//
//  BookEntity+CoreDataProperties.swift
//  HomeShelf
//
//  Created by Mykola Chaikovskyi on 14.06.2023.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var author: String
    @NSManaged public var cover: Data
    @NSManaged public var isFavorite: Bool
    @NSManaged public var loanedTo: String
    @NSManaged public var pageCount: Int16
    @NSManaged public var progress: Int16
    @NSManaged public var rating: Int16
    @NSManaged public var review: String
    @NSManaged public var storeUrl: String
    @NSManaged public var title: String
    @NSManaged public var inUserList: [String]

}

extension BookEntity : Identifiable {

}
