//
//  AutentificacionError.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

// MARK: - Errores de iniciar sesión con email
//Tipos de errores en el momento de la autentificación de los usuarios con email
/* Es obligatorio que implemente la clase Error para la gestión de los errores */
enum EmailAutentificacionError: Error {
    
    case incorrectPassword
    case invalidEmail
    case accoundDoesNotExist
    case unknownError
    case couldNotCreate
    case extraDataNotCreated
}
//Identificamos el tipo de error
extension EmailAutentificacionError: LocalizedError {
   
    var errorDescription: String? {
        switch self {
            //Contraseña incorrecta
        case .incorrectPassword:
            return NSLocalizedString("iniciarSesion-password-incorrecta", comment: "")
            //Formato email no válido
        case .invalidEmail:
            return NSLocalizedString("iniciarSesion-email-incorrecto", comment: "")
            //El emial introducido no coincide con ninguna cuenta registrada
        case .accoundDoesNotExist:
            return NSLocalizedString("iniciarSesion-email-no-existe", comment: "")
            //Error desconocido
        case .unknownError:
            return NSLocalizedString("iniciarSesion-error-desconocido-validacion", comment: "")
            //No es posible crear la cuenta
        case .couldNotCreate:
            return NSLocalizedString("No se pudo crear una cuenta de usuario en este momento", comment: "")
            //No se puede guardar un campo en este momento
        case .extraDataNotCreated:
            return NSLocalizedString("No se puede guardar el nombre completo en este momento", comment: "")
        }
    }
}

/* Mensajes de errores los tratamos para enviar el mensaje que deseamos */
enum ErroresString{
    
    enum ErroresRegistrar{
        static let existeEmail = "The email address is already in use by another account."
        static let existeEmailTraduccion =  "registrarCuenta-existe-email"
        static let existeNombreUsuario = "registrarCuenta-existe-nombre-usuario"
    }
    enum ErroresCambiarContraseña{
        static let noExisteUsuario = "There is no user record corresponding to this identifier. The user may have been deleted."
        static let noExisteUsuarioTraduccion = "cambiar-password-error-noexiste-usuario"
    }
    enum ErroresReAutentificacion{
        static let passwordIncorrecta = "The password is invalid or the user does not have a password."
        static let passwordIncorrectaTraduccion = "reautentificacion-error-password-incorrecto"
    }
}

