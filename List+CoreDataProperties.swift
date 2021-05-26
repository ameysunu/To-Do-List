//
//  List+CoreDataProperties.swift
//  ToDo
//
//  Created by Amey Sunu on 26/05/21.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var category: String
    
    var orderStatus: Category {
        set {
            category = newValue.rawValue
        }
        get {
            Category(rawValue: category) ?? .Other
        }
    }

}

extension List : Identifiable {

}

enum Category: String {
    case Other = "Other"
    case Business = "Business"
    case Personal = "Personal"
}
