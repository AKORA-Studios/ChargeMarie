//
//  UserInformation+CoreDataProperties.swift
//  openWB App
//
//  Created by Akora on 28.03.22.
//
//

import Foundation
import CoreData


extension UserInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInformation> {
        return NSFetchRequest<UserInformation>(entityName: "UserInformation")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension UserInformation : Identifiable {

}
