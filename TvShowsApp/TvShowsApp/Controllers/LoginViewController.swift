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
    @IBOutlet weak var rememberButton: UIButton!
    
    // MARK: - Variables
    
    var email: String = ""
    var password: String = ""
    var adapter: AlamofireAdapter = AlamofireAdapter()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        subscribeToKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        resetLogin()
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
    
    func resetLogin() {
        rememberButton.isSelected = false
        emailTextField.text = ""
        passwordTextField.text = ""
        email = ""
        password = ""
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
    
    // MARK: - Keyboard setup
    
    @objc func keyboardWillShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func subscribeToKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
