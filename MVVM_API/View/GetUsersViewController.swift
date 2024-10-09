//
//  GetUsersViewController.swift
//  MVVM_API
//
//  Created by Mahmudul Hasan on 2/10/24.
//

//import UIKit
//
//class GetUsersViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//    var viewModel : UserViewModel?
//    var users : [UserModel] = []
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupTableView()
//
//
//
//        viewModel?.reloadTableViewClosure = { [weak self] in
//
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//
//        viewModel?.fetchUsersFromCoreData()
//     }
//
//    private func setupTableView() {
//        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "cell")
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    private func fetchUsersFromCoreData() {
//        viewModel.getUsers { [weak self] result in
//            switch result{
//            case .success(let fetchedUser):
//                DispatchQueue.main.async {
//                    print(result)
//                    self?.users = fetchedUser
//                    self?.tableView.reloadData()
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    print(error.localizedDescription)
//                    self?.showAlert("Failed to fetch users: \(error.localizedDescription)")
//                }
//
//            }
//        }
//    }
//
//
//        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            if editingStyle == .delete {
//                let user = users[indexPath.row]
//                userViewModel.deleteUser(with: user.id!) { [weak self] result in
//                    switch result {
//                    case .success:
//                        DispatchQueue.main.async {
//                            self?.users.remove(at: indexPath.row)
//                            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
//                        }
//                    case .failure(let error):
//                        DispatchQueue.main.async {
//                            self?.showAlert("Failed to delete user: \(error.localizedDescription)")
//                        }
//                    }
//                }
//            }
//        }
//
//    private func showAlert(_ message: String) {
//           let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: "OK", style: .default))
//           present(alert, animated: true)
//       }
//
//
//}
//
//extension GetUsersViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return users.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UserTableViewCell
//        else {
//         return UITableViewCell()
//        }
//        let user = users[indexPath.row]
//        cell.configure(with: user)
//        return cell
//    }
//
//
//}

import UIKit

class GetUsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var getUserViewModel: GetUserViewModel?
    var deleteUserViewModel: DeleteUserViewModel?
    
    var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        getUserViewModel?.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsersFromAPI()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchUsersFromAPI() {
        getUserViewModel?.getUsers { [weak self] result in
            switch result {
            case .success(let fetchedUsers):
                DispatchQueue.main.async {
                    self?.users = fetchedUsers
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    self?.showAlert("Failed to fetch users: \(error.localizedDescription)")
                }
            }
        }
    }

 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = users[indexPath.row]
            deleteUserViewModel?.deleteUser(with: user.id ?? 0) { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.users.remove(at: indexPath.row)
                        self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert("Failed to delete user: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension GetUsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
}
