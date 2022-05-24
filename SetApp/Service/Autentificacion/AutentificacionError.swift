//
//  AutentificacionError.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

// MARK: - Signin in with email errors
//Tipos de errores en el momento de la autentificación de los usuarios
/* Es obligatorio que implemente la clase Error para la gestión de los errores */
enum EmailAutentificacionError: Error {
    
    case incorrectPassword
    case invalidEmail
    case accoundDoesNotExist
    case unknownError
    case couldNotCreate
    case extraDataNotCreated
}

extension EmailAutentificacionError: LocalizedError {
    // This will provide me with a specific localized description for the EmailAuthError
    var errorDescription: String? {
        switch self {
        case .incorrectPassword:
            return NSLocalizedString("La contraseña introducida es incorrecta", comment: "")
            //Incorrect Password for this account
        case .invalidEmail:
             return NSLocalizedString("Introduce una dirección de email válida", comment: "")
            //Not a valid email address
        case .accoundDoesNotExist:
            return NSLocalizedString("La dirección de email introducida no coincide con ninguna cuenta", comment: "")
            //Not a valid email address.  This account does not exist.
        case .unknownError:
            return NSLocalizedString("Error desconocido. No es posible iniciar sesión, por favor contacta con servicio al cliente", comment: "")
            //Unknown error.  Cannot log in.
        case .couldNotCreate:
            return NSLocalizedString("No se pudo crear una cuenta de usuario en este momento", comment: "")
            //Could not create user at this time.
        case .extraDataNotCreated:
            return NSLocalizedString("No se puede guardar el nombre completo en este momento", comment: "")
            //Could not save user's full name.
        }
    }
}

/* Mensajes de errores los tratamos para enviar el mensaje que deseamos */
enum ErroresString{
    
    enum ErroresRegistrar{
        static let existeEmail = "The email address is already in use by another account."
        static let existeEmailTraduccion =  "La dirección de correo electrónico introducida ya existe"
        static let existeNombreUsuario = "El nombre de usuario introducido ya existe, añade otro"
    }
    enum ErroresCambiarContraseña{
        static let noExisteUsuario = "There is no user record corresponding to this identifier. The user may have been deleted."
        static let noExisteUsuarioTraduccion = "No existe registro de usuario correspondiente a este identificador. El usuario puede haber sido eliminado"
    }
    enum ErroresReAutentificacion{
        static let passwordIncorrecta = "The password is invalid or the user does not have a password."
        static let passwordIncorrectaTraduccion = "La contraseña no es válida o el usuario no tiene contraseña."
    }
}

