//
//  ToDo+CoreDataProperties.swift
//  ToDo
//
//  Created by Amey Sunu on 26/05/21.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var title: String
    @NSManaged public var body: String
    @NSManaged public var category: String
    @NSManaged public var done: Bool
    
    var categoryValue: Category {
         set {
             category = newValue.rawValue
         }
         get {
             Category(rawValue: category) ?? .other
         }
     }

}

extension ToDo : Identifiable {

}

enum Category: String {
    case business = "Business"
    case personal = "Personal"
    case other = "Other"
}
