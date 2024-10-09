//
//  UserModelView.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 1/10/24.
//

//import Foundation
//import UIKit
//import CoreData
//
//class UserViewModel {
//
//    let context : NSManagedObjectContext
//
//    var coreDataUsers: [UserDataModel] = []
//
//    var apiUsers : [UserModel] = []
//
//    var reloadTableViewClosure: (() -> Void)?
//
//    init(context: NSManagedObjectContext){
//        self.context = context
//    }
//
//
//    //Insert to coredata
//    func addUserToCoreData(name:String, email:String, address: String) {
//
//        let newUser = UserDataModel(context: context)
//        newUser.name = name
//        newUser.email = email
//        newUser.address = address
//
//        do {
//            try context.save()
//            fetchUsersFromCoreData()
//        }  catch let error {
//            print("Failed to save user: \(error.localizedDescription)")
//        }
//    }
//
//    func fetchUsersFromCoreData() {
//
//        let fetchRequest: NSFetchRequest<UserDataModel> = UserDataModel.fetchRequest()
//
//        do {
//            coreDataUsers = try context.fetch(fetchRequest)
//        } catch let error {
//            print("Failed to fetch users from Core Data: \(error.localizedDescription)")
//        }
//
//    }
//
//
//    func addUserToAPI(name: String, email: String, address: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
//
//        // Create the URL
//        guard let url = URL(string: "http://localhost:3000/users") else {
//            print("Invalid URL")
//            return
//        }
//
//        // Create a User object
//        let newUser = UserModel(id: nil, name: name, email: email, address: address)
//
//        // Convert User to JSON data
//        guard let jsonData = try? JSONEncoder().encode(newUser) else {
//            print("Error encoding user data")
//            return
//        }
//
//        // Create a URLRequest and set it to POST
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//
//        // Make the POST request
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            // Check for valid response and data
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            // Decode the response
//            do {
//                let createdUser = try JSONDecoder().decode(UserModel.self, from: data)
//                completion(.success(createdUser))
//            } catch let decodingError {
//                completion(.failure(decodingError))
//            }
//        }
//        task.resume()
//    }
//
//    func getUsers(completion: @escaping(Result<[UserModel], Error>) -> Void) {
//
//        guard let url = URL(string: "http://localhost:3000/users") else {
//            print("Invalid URL")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            do {
//                let users = try JSONDecoder().decode([UserModel].self, from: data)
//                completion(.success(users))
//            } catch let error{
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//
//    func deleteUser(with id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
//            guard let url = URL(string: "http://localhost:3000/users/\(id)") else {
//                print("Invalid URL")
//                return
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "DELETE"
//
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//
//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                    completion(.success(()))
//                } else {
//                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to delete user"])
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//
//
//}
