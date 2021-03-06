//
//  Claves.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

/* Guardaremos los nombres de las colecciones de la bases de datos de firebase. También los atributos del usuario */
enum Claves {
    
    //El nombre de la colección en firebase
    enum RutaColeccion {
        //Para los usuarios
        static let usuarios = "usuarios"
        //Para la foto de perfil de los usuarios
        static let usuarioImagenPerfil = "fotoPerfil"
        //Para la coleccion post
        static let allPost = "allPosts"
        //Para la coleccion post
        static let post = "posts"
    }
    
    // Los atributos que tendrán el usuario
    enum Usuario {
        static let id = "id"
        static let nombreCompleto = "nombreCompleto"
        static let nombreUsuario = "nombreUsuario"
        static let email = "email"
        static let sexo = "sexo"
        static let fechaNacimiento = "fechaNacimiento"
        static let urlImagenPerfil = "urlImagenPerfil"
    }
    
}
