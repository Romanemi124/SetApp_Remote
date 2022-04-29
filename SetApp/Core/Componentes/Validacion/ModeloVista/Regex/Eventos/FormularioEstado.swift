//
//  FormularioEstado.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

import Foundation

/* Esta clase nos va a servir para indicar si el formulario está correcto o no */
enum FormularioEstado {

    //Si es valido o no
    case validar(usuario: UsuarioRegistro)
    // Si no es valido nos mostrará el error ocurrido
    case error(personalizado: ValidarError)
}

//Mediante eventos evaluamos si el formulario está correcto o no
extension FormularioEstado: Equatable {
    
    static func == (lhs: FormularioEstado, rhs: FormularioEstado) -> Bool {
        
        //Indenficamos si es valido o si tiene un error
        switch (lhs, rhs) {
            
        case (.validar(usuario: let lhsType),
              .validar(usuario: let rhsType)):
            
            return lhsType == rhsType
            
        case (.error(personalizado: let lhsType),
              .error(personalizado: let rhsType)):
            
            return lhsType.descripcionError == rhsType.descripcionError
            
        default:
            
            return false
        }
    }
}
