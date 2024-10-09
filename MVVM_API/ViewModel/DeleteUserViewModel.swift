//
//  DeleteUserViewModel.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 9/10/24.
//

import Foundation

class DeleteUserViewModel {
    
    let apiHelper: UserAPIHelper
    let coreDataHelper: UserCoreDataHelper
    var reloadTableViewClosure: (() -> Void)?
    
    init(apiHelper: UserAPIHelper, coreDataHelper: UserCoreDataHelper) {
        self.apiHelper = apiHelper
        self.coreDataHelper = coreDataHelper
    }
    
    func deleteUser(with id: Int) {
        
        apiHelper.deleteUser(with: id) { [weak self] result in
            switch result {
            case .success:
                print("User deleted successfully from API")
                self?.reloadTableViewClosure?()
            case .failure(let error):
                print("Failed to delete user from API: \(error.localizedDescription)")
            }
        }
        
        
        deleteUserFromCoreData(withId: id)
    }
    
    private func deleteUserFromCoreData(withId id: Int) {
        let fetchRequest = UserDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let users = try coreDataHelper.context.fetch(fetchRequest)
            if let userToDelete = users.first {
                coreDataHelper.context.delete(userToDelete)
                try coreDataHelper.context.save()
                print("User deleted from Core Data")
            }
        } catch let error {
            print("Failed to delete user from Core Data: \(error.localizedDescription)")
        }
    }
}
