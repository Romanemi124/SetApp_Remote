//
//  FBKeys.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

/* Guardaremos los nombres y las rutas de las bases de datos de firebase */
enum FBKeys {
    
    //El nombre de la colección en firebase
    enum CollectionPath {
        //Seleccionamos el nombre
        static let users = "usuarios"
    }
    
    // Los atributos que tendrán el usuario
    enum User {
        
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
        
        // Add app specific keys here
    }
}
