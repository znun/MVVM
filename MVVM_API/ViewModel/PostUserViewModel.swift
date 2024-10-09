//
//  PostUserViewModel.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 9/10/24.
//

import Foundation

class PostUserViewModel {
    
    let apiHelper: UserAPIHelper
    let coreDataHelper: UserCoreDataHelper
    
    var reloadTableViewClosure: (() -> Void)?
    
    init(apiHelper: UserAPIHelper, coreDataHelper: UserCoreDataHelper) {
        self.apiHelper = apiHelper
        self.coreDataHelper = coreDataHelper
    }
    
    func addUser(name: String, email: String, address: String) {
    
        apiHelper.addUserToAPI(name: name, email: email, address: address) { result in
            switch result {
            case .success(_):
                self.reloadTableViewClosure?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        coreDataHelper.addUserToCoreData(name: name, email: email, address: address)
    }
}
