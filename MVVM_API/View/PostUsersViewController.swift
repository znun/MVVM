//
//  ViewController.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 1/10/24.
//

//import UIKit
//import CoreData
//
//class PostUsersViewController: UIViewController {
//
//    @IBOutlet weak var nameTF: UITextField!
//    @IBOutlet weak var emailTF: UITextField!
//    @IBOutlet weak var addressTF: UITextField!
//
//    var viewModel : UserViewModel?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//        let context = appDelegate.persistentContainer.viewContext
//        viewModel = UserViewModel(context: context)
//
//    }
//
//
//    @IBAction func submitBtnPressed(_ sender: Any) {
//
//        guard let name = nameTF.text, !name.isEmpty,
//              let email = emailTF.text, !email.isEmpty,
//              let address = addressTF.text, !address.isEmpty else {
//              print("Please fill in all fields")
//              return
//        }
//
//        viewModel?.addUserToCoreData(name: name, email: email, address: address)
//
//        let newUser = UserModel(id: nil, name: name, email: email, address: address)
//        viewModel?.addUserToAPI(user: newUser) { result in
//                    switch result {
//                    case .success(let user):
//                        print("User added to API: \(user)")
//                        self?.showAlert("User created: \(user.name)")
//                        self?.clearInputFields()
//                    case .failure(let error):
//                        print("Failed to add user to API: \(error)")
//                    }
//                }
//
//    }
//
//    private func showAlert(_ message: String) {
//           let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: "OK", style: .default))
//           present(alert, animated: true)
//       }
//
//    private func clearInputFields() {
//            nameTF.text = ""
//            emailTF.text = ""
//            addressTF.text = ""
//        }
//
//}
//
//import UIKit
//
//class PostUserViewController: UIViewController {
//
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var addressTextField: UITextField!
//
//    var postUserViewModel: PostUserViewModel?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let apiHelper = UserAPIHelper()
//        let coreDataHelper = UserCoreDataHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
//        postUserViewModel = PostUserViewModel(apiHelper: apiHelper, coreDataHelper: coreDataHelper)
//    }
//
//    @IBAction func submitButtonTapped(_ sender: UIButton) {
//        guard let name = nameTextField.text, !name.isEmpty,
//              let email = emailTextField.text, !email.isEmpty,
//              let address = addressTextField.text, !address.isEmpty else {
//            showAlert("All fields are required")
//            return
//        }
//
//
//        postUserViewModel?.addUser(name: name, email: email, address: address)
//    }
//
//    private func showAlert(_ message: String) {
//        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//
//}


import UIKit
import CoreData

class PostUsersViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    var postUserViewModel: PostUserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let apiHelper = UserAPIHelper()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let coreDataHelper = UserCoreDataHelper(context: context)
        postUserViewModel = PostUserViewModel(apiHelper: apiHelper, coreDataHelper: coreDataHelper)
    }

    @IBAction func submitBtnPressed(_ sender: Any) {
        guard let name = nameTF.text, !name.isEmpty,
              let email = emailTF.text, !email.isEmpty,
              let address = addressTF.text, !address.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        postUserViewModel?.addUser(name: name, email: email, address: address)
        
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func clearInputFields() {
        nameTF.text = ""
        emailTF.text = ""
        addressTF.text = ""
    }
}
