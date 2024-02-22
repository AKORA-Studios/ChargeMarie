//
//  UserInformation+CoreDataProperties.swift
//  ChargeMarie
//
//  Created by Kiara on 14.09.22.
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
    @NSManaged public var adress: String?

}

extension UserInformation : Identifiable {

}
