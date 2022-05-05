//
//  Post.swift
//  SetApp
//
//  Created by Emilio Roman on 3/5/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Encodable, Decodable {
    
    var likes: [String: Bool]
    var geoLocation: String
    var OwnerId: String
    var postId: String
    //var username: String
    //var profile: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
    var categoria: String
    var nombreProducto: String
    var marca: String
    var valoracion: String
    var caracteristicas: String
}

