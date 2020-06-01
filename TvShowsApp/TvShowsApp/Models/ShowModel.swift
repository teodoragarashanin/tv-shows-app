//
//  ShowModel.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import Foundation


struct ShowModel: Decodable {
    let data: [Show]
}

struct Show: Decodable {
    let showID: String
    let title: String
    let imageUrl: String
    //let likesCount: Int
    
    private enum CodingKeys : String, CodingKey {
        case showID = "_id", title, imageUrl
    }
}
