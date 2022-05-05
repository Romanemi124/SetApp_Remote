//
//  Publicacion.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Publicacion: Encodable, Decodable {
    
    var caption: String
    var likes: [String: Bool]
    var geoLocation: String
    var OwnerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
    var categoria: String
    var nombreProducto: String
    var marca: String
    var valoracion: String
    var caracteristicas: String
    
    /*
    /* @DocumentID indicar que se trata del id del usuario */
    @DocumentID var id: String?
    let UrlImagePublicacion: String
    let categoria: String
    let nombreProducto: String
    let marca: String
    let valoracion: String
    let caracteristicas: String
    var likes: Int
    let timestamp: Timestamp
    let idUser: String
    
    var user: Usuario?
     */
}
