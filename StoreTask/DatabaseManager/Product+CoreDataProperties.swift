//
//  Product+CoreDataProperties.swift
//  StoreTask
//
//  Created by Mac on 04/07/18.
//  Copyright © 2018 Me. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var quantity: Int16

}
