//
//  Planet+CoreDataProperties.swift
//  Planets
//
//  Created by Vibha Mangrulkar on 2021/11/20.
//
//

import Foundation
import CoreData


extension Planet {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Planet> {
        return NSFetchRequest<Planet>(entityName: "Planet")
    }
    
    @NSManaged public var climate: String
    @NSManaged public var created: String
    @NSManaged public var diameter: String
    @NSManaged public var edited: String
    @NSManaged public var gravity: String
    @NSManaged public var name: String
    @NSManaged public var orbitalPeriod: String
    @NSManaged public var population: String
    @NSManaged public var rotationPeriod: String
    @NSManaged public var surfaceWater: String
    @NSManaged public var terrain: String
    @NSManaged public var url: String
    @NSManaged public var residents: [String]
    @NSManaged public var films: [String]
    
}

extension Planet : Identifiable {
    
}
