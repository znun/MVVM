//
//  UserAPIHelper.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 9/10/24.
//

import Foundation

class UserAPIHelper {
    
    func addUserToAPI(name: String, email: String, address: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users") else {
            print("Invalid URL")
            return
        }
        
        let newUser = UserModel(id: nil, name: name, email: email, address: address)
        guard let jsonData = try? JSONEncoder().encode(newUser) else {
            print("Error encoding user data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let createdUser = try JSONDecoder().decode(UserModel.self, from: data)
                completion(.success(createdUser))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: data)
                completion(.success(users))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func deleteUser(with id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:3000/users/\(id)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to delete user"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
