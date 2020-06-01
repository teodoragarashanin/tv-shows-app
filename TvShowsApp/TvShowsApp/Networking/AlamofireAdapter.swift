//
//  ApiClient.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import Foundation
import Alamofire


class ApiRequest {
    var url: String
    var method: HTTPMethod
    var params: [String: Any]?

    init(url: String, method: HTTPMethod, params: [String: Any]? = nil) {
        self.url = url
        self.method = method
        self.params = params
    }
}

class AlamofireAdapter {
    
    func fetch(with request: ApiRequest, completion: @escaping (Result<Data, AFError>) -> Void){
        AF.request(request.url, method: request.method, parameters: request.params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in completion(response.result) }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        let data = LoginData(email: email, password: password).toDictionary()
        let request = ApiRequest(url: Constants.LOGIN_URL, method: .post, params: data)
        fetch(with: request, completion: completion)
    }
    
}

