//
//  LoginModel.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import Foundation

struct LoginModel: Decodable {
    let data: LoginModelData
}

struct LoginModelData: Decodable {
    let token: String
}
