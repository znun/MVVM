//
//  UserModel.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 1/10/24.
//

import Foundation

struct UserModel: Codable {
    let id: Int?
    let name: String
    let email: String
    let address: String
}
