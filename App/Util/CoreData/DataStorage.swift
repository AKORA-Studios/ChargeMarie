//
//  DataStorage.swift
//  openWB App
//
//  Created by Kiara on 28.03.22.
//

import Foundation
import CoreData

struct DataStorage{
    
    static func logout(){
        let context = CoreDataStack.shared.managedObjectContext
        let data  = DataStorage.getData()
        data.password = ""
        
        try!  context.save()
    }
    
    static func saveLogIn(_ username: String, _ password: String){
        let context = CoreDataStack.shared.managedObjectContext
        let data  = DataStorage.getData()
        data.username = username
        data.password = password
        
        try!  context.save()
    }
    
    static func saveAdress(_ adress: String){
        let context = CoreDataStack.shared.managedObjectContext
        let data  = DataStorage.getData()
        data.adress = adress
        
        try!  context.save()
    }
    
    static func saveUsername(_ username: String){
        let context = CoreDataStack.shared.managedObjectContext
        let data  = DataStorage.getData()
        data.username = username
        
        try!  context.save()
    }
    
    static func getData() -> UserInformation{
        let context = CoreDataStack.shared.managedObjectContext
        
        var data: UserInformation?
        do {
            let items = try context.fetch(UserInformation.fetchRequest())
            if(items.count != 0){ data = items[0]}
        }
        catch{  }
        
        if(data == nil){
            let item = UserInformation(context: context)
            item.username = ""
            item.password = ""
            item.adress = ""
            
            try! context.save()
            return item
        }
        return data!
    }
}

