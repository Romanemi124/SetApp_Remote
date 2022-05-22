//
//  PostPrueba.swift
//  SetApp
//
//  Created by Emilio Roman on 18/5/22.
//

import FirebaseFirestoreSwift
import Firebase

//Esto se usa para mostrar las publicaciones de las categorias
struct PostCateg: Identifiable, Decodable {
    
    @DocumentID var id: String?
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
    var link: String
    var puntosPositivos: String
    var puntosNegativos: String
}
