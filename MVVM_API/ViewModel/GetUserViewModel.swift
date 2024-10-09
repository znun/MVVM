//
//  GetUserViewModel.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 9/10/24.
//

import Foundation

class GetUserViewModel {
    
    let apiHelper: UserAPIHelper
    let coreDataHelper: UserCoreDataHelper
    var reloadTableViewClosure: (() -> Void)?
    
    var users: [UserModel] = [] {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    init(apiHelper: UserAPIHelper, coreDataHelper: UserCoreDataHelper) {
        self.apiHelper = apiHelper
        self.coreDataHelper = coreDataHelper
    }
    
    func fetchUsers() {
       
        apiHelper.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
