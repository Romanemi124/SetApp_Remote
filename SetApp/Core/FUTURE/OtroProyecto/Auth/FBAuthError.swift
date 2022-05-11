//
//  FBError.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation
/* En esta clase mostraremos el mensaje de todos los erroes realacionadas con la autentificación del usuario */

// MARK: - SignIn with Apple Erors
enum SignInWithAppleAuthError: Error {
    case noAuthDataResult
    case noIdentityToken
    case noIdTokenString
    case noAppleIDCredential
}

extension SignInWithAppleAuthError: LocalizedError {
    // This will provide me with a specific localized description for the SignInWithAppleAuthError
    var errorDescription: String? {
        switch self {
        case .noAuthDataResult:
            return NSLocalizedString("No Auth Data Result", comment: "")
        case .noIdentityToken:
            return NSLocalizedString("Unable to fetch identity token", comment: "")
        case .noIdTokenString:
            return NSLocalizedString("Unable to serialize token string from data", comment: "")
        case .noAppleIDCredential:
            return NSLocalizedString("Unable to create Apple ID Credential", comment: "")
        }
    }
}

// MARK: - Signin in with email errors
//Tipos de errores en el momento de la autentificación de los usuarios 
enum EmailAuthError: Error {
    case incorrectPassword
    case invalidEmail
    case accoundDoesNotExist
    case unknownError
    case couldNotCreate
    case extraDataNotCreated
}

extension EmailAuthError: LocalizedError {
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




