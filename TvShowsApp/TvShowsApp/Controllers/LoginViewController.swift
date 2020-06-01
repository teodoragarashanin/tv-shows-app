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
    }
    
    // MARK - Login Setup
    
    func loginUser(email: String, password: String) {
        adapter.loginUser(email: email, password: password) { [weak self] (result) in
            switch result {
            case .success(let token):
                print(token)
                self?.presetnTvShowsVC()
            case .failure( _):
                self?.showAlert(title: "Login failed.", message: "Please try again with another credentials")
            }
        }
    }
    
    func presetnTvShowsVC() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ShowsVC")
        navigationController?.show(vc, sender: self)
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
        sender.isSelected = !sender.isSelected
        UserDefaults.standard.set(sender.isSelected, forKey: Constants.REMEMBERED)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if email.isEmpty || password.isEmpty {
            showAlert(title: "Error", message: "Please enter your email and password.")
        } else if !email.isEmailValid() {
             showAlert(title: "Error", message: "Invalid email address. Please try with another one.")
        } else {
             loginUser(email: email, password: password)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}


