//
//  Usuario.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 6/4/22.
//

import FirebaseFirestoreSwift

/* DEPRECATED  */

//Tabla Usuarios de nuestra base de datos
//Creamos el objecto usuario
struct Usuario: Identifiable, Decodable{
    
    /* @DocumentID indicar que se trata del id del usuario */
    @DocumentID var id: String?
    let nombreUsuario: String
    let nombreCompleto: String
    let email: String
    let sexo: String
    let fechaNacimiento: String
    let UrlImagenPerfil: String
    
}
