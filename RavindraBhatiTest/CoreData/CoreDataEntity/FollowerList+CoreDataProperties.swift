//
//  FollowerList+CoreDataProperties.swift
//  RavindraBhatiTest
//
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData


extension FollowerList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FollowerList> {
        return NSFetchRequest<FollowerList>(entityName: "FollowerList")
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
