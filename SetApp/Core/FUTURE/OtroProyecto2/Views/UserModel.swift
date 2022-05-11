//
//  UserModel.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import SwiftUI

struct UserModel: Encodable, Decodable {
    var uid: String
    var emial:String
    var profileImageUrl:String
    var userName: String
    var searchName:[String]
    var bio:String
}
