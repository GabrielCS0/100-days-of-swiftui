//
//  CachedFriend+CoreDataProperties.swift
//  C4-ISocial
//
//  Created by Gabriel on 07/06/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var users: NSSet?

    
    public var wrappedId: String {
        id ?? "c004b305"
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var usersArray: [CachedUser] {
        let set = users as? Set<CachedUser> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for users
extension CachedFriend {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: CachedUser)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: CachedUser)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
