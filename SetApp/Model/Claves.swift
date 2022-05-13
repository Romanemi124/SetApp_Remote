//
//  Claves.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

/* Guardaremos los nombres y las rutas de las bases de datos de firebase. También los atributos del usuario*/
enum Claves {
    
    //El nombre de la colección en firebase
    enum RutaColeccion {
        //Seleccionamos el nombre
        static let usuarios = "usuarios"
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