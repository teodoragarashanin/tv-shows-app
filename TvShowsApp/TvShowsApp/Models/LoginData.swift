//
//  LoginData.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import Foundation

class LoginData {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func toDictionary() -> [String: String] {
        return ["email": email, "password": password]
    }
    
}
