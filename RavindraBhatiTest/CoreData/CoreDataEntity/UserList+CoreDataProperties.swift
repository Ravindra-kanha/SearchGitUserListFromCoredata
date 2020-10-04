//  UserList+CoreDataProperties.swift
//  RavindraBhatiTest
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.

import Foundation
import CoreData


extension UserList {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserList> {
        return NSFetchRequest<UserList>(entityName: "UserList")
    }
    
    @NSManaged public var login: String?
    @NSManaged public var id: Int64
    @NSManaged public var avatar_url: String?
    @NSManaged public var url: String?
    @NSManaged public var followers_url: String?
    @NSManaged public var type: String?
    @NSManaged public var site_admin: Bool
    @NSManaged public var score: Float
    
}
