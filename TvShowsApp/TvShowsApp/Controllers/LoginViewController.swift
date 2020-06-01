//
//  LoginViewController.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Variables
    
    var email: String = ""
    var password: String = ""
    var adapter: AlamofireAdapter = AlamofireAdapter()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
       // registerNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scrollView.contentInset.bottom = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK - Login Setup
    
    func loginUser(email: String, password: String) {
        adapter.loginUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .success(let data):
                let model = try? JSONDecoder().decode(LoginModel.self, from: data)
                print(model)
            case .failure(let error):
                self?.showAlert(title: "Login failed.", message: "Please try again with another credentials")
            }
        }
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        email = text
        
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        password = text
    }
    
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ShowsVC")
        navigationController?.show(vc, sender: self)
//        if email.isEmailValid() {
//            if password.isEmpty {
//                    showAlert(title: "Error", message: "Please enter password.")
//            } else {
//                 loginUser(email: email, password: password)
//            }
//        } else {
//            showAlert(title: "Error", message: "Invalid email address. Please try with another one.")
//        }
     
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}


