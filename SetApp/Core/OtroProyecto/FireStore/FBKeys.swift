//
//  FBKeys.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation
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
