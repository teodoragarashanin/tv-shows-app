//
//  ApiClient.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import Foundation
import Alamofire


class AlamofireRequest {
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
    
    func fetch<T: Decodable>(with request: AlamofireRequest, dataType: T.Type, completion: @escaping (Result<T, AFError>) -> Void){
        AF.request(request.url, method: request.method, parameters: request.params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let model = self.parseData(type: dataType, data: data)
                    completion(Result.success(model!))
                case .failure(let error): ()
                    
                }
        }
    }
    
    func parseData<T: Decodable>(type: T.Type, data: Data) -> T? {
        do {
            let genericModel = try JSONDecoder().decode(type, from: data)
            return genericModel
        } catch {
            return nil
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<LoginModel, AFError>) -> Void) {
        let data = LoginData(email: email, password: password).toDictionary()
        let request = AlamofireRequest(url: Constants.LOGIN_URL, method: .post, params: data)
        fetch(with: request, dataType: LoginModel.self, completion: completion)
    }
    
    func fetchShows(completion: @escaping (Result<ShowModel, AFError>) -> Void) {
        let request = AlamofireRequest.init(url: Constants.SHOWS_URL, method: .get)
        fetch(with: request, dataType: ShowModel.self, completion: completion)
    }
    
}

