//  UserList+CoreDataClass.swift
//  RavindraBhatiTest
//  Created by Apple on 22/08/20.
//  Copyright © 2020 Apple. All rights reserved.

import Foundation
import CoreData

@objc(UserList)
public class UserList: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatar_url = "avatar_url"
        case url = "url"
        case followers_url = "followers_url"
        case type = "type"
        case score = "score"
        case site_admin = "site_admin"
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "UserList", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
            followers_url = try values.decodeIfPresent(String.self, forKey: .followers_url)
            id = try values.decodeIfPresent(Int64.self, forKey: .id) ?? 0
            login = try values.decodeIfPresent(String.self, forKey: .login)
            score = try values.decodeIfPresent(Float.self, forKey: .score) ?? 0.0
            site_admin = try values.decodeIfPresent(Bool.self, forKey: .site_admin) ?? false
            type = try values.decodeIfPresent(String.self, forKey: .type)
            url = try values.decodeIfPresent(String.self, forKey: .url)
            
        } catch {
            print ("User List Decoding error")
        }
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encodeIfPresent(avatar_url ?? "", forKey: .avatar_url)
            try container.encodeIfPresent(followers_url ?? "", forKey: .followers_url)
            try container.encodeIfPresent(id , forKey: .id)
            try container.encodeIfPresent(login ?? "", forKey: .login)
            try container.encodeIfPresent(url ?? "", forKey: .login)
            try container.encodeIfPresent(type ?? "", forKey: .type)
            try container.encodeIfPresent(score , forKey: .score)
            try container.encodeIfPresent(site_admin , forKey: .site_admin)
        } catch {
            print("User List Encoding error")
        }
    }
}
