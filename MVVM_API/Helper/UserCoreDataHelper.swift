//
//  UserCoreDataHelper.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 9/10/24.
//

import Foundation
import CoreData

class UserCoreDataHelper {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addUserToCoreData(name: String, email: String, address: String) {
        let newUser = UserDataModel(context: context)
        newUser.name = name
        newUser.email = email
        newUser.address = address
        
        do {
            try context.save()
        } catch let error {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func fetchUsersFromCoreData() -> [UserDataModel] {
        let fetchRequest: NSFetchRequest<UserDataModel> = UserDataModel.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch users from Core Data: \(error.localizedDescription)")
            return []
        }
    }
}
