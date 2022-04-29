//
//  ValidarError.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

import Foundation

/* Esta lista permitirá manejar los errores personalizados */
enum ValidarError: Error {
    case personalizado(mensaje: String)
}

extension ValidarError {
    
    var descripcionError: String {
        switch self {
            //Mostrar el menseaje personalizado con el error
        case .personalizado(let mensaje):
            return mensaje
        }
    }
}

