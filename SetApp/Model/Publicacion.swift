//
//  Publicacion.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Publicacion: Identifiable, Decodable {
    
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
}
