//
//  UsuarioFireBase.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation
import FirebaseFirestoreSwift

/* Modelo de usuario para el usuario en FireBase */
struct UsuarioFireBase: Identifiable, Decodable {
    
    /* @DocumentID indicar que se trata del id del usuario */
    @DocumentID var id: String?
    let nombreCompleto: String
    let nombreUsuario: String
    let email: String
    let sexo: String
    let fechaNacimiento: String
    let urlImagenPerfil: String
    
    //Inicializamos el objecto usuario con estos atributos
    init(id: String, nombreCompleto: String, nombreUsuario: String, email: String, sexo: String, fechaNacimiento: String, urlImagenPerfil: String) {
        self.id = id
        self.nombreCompleto = nombreCompleto
        self.nombreUsuario = nombreUsuario
        self.email = email
        self.sexo = sexo
        self.fechaNacimiento = fechaNacimiento
        self.urlImagenPerfil = urlImagenPerfil
    }
    
}

/* Las extensiones permiten agregar métodos y/o atributos a objectos existentes, de esta forma ese objecto tendrá esos atributos y/o acciones agregadas
 Por ejemplo, UsuarioFireBase ahora tendrá el método dataDict()*/
extension UsuarioFireBase {
    
    //Crear un diccionarío con todas las claves y valores cuando se crea la instacia
    //Utilizamos el enumerado Claves para controlar las claves que se añaden en el diccionario
    init?(documentData: [String : Any]) {
        
        let id = documentData[Claves.Usuario.id] as? String ?? ""
        let nombreCompleto = documentData[Claves.Usuario.nombreCompleto] as? String ?? ""
        let nombreUsuario = documentData[Claves.Usuario.nombreUsuario] as? String ?? ""
        let email = documentData[Claves.Usuario.email] as? String ?? ""
        let sexo = documentData[Claves.Usuario.sexo] as? String ?? ""
        let fechaNacimiento = documentData[Claves.Usuario.fechaNacimiento] as? String ?? ""
        let urlImagenPerfil = documentData[Claves.Usuario.urlImagenPerfil] as? String ?? ""
        
        //Inicilizamos el usuario
        self.init(id: id,
                  nombreCompleto: nombreCompleto,
                  nombreUsuario: nombreUsuario,
                  email: email,
                  sexo: sexo,
                  fechaNacimiento: fechaNacimiento,
                  urlImagenPerfil: urlImagenPerfil)
    }
    
    // Utilizaremos está función para asegurarnos de no sobreescribir ningún dato existente
    static func dataDict(id: String, nombreCompleto: String, nombreUsuario: String, email: String, sexo: String,fechaNacimiento: String, urlImagenPerfil: String) -> [String: Any] {
        
        var data: [String: Any]
        
        //Si el nombre no está vacío, debe ser una entrada nueva, así que agregue todos los datos de la primera vez
        if nombreCompleto != "" {
            data = [
                Claves.Usuario.id: id,
                Claves.Usuario.nombreCompleto: nombreCompleto,
                Claves.Usuario.nombreUsuario: nombreUsuario,
                Claves.Usuario.email: email,
                Claves.Usuario.sexo: sexo,
                Claves.Usuario.fechaNacimiento: fechaNacimiento,
                Claves.Usuario.urlImagenPerfil: urlImagenPerfil
            ]
        } else {
            /* Esta es una entrada posterior, así que solo combine uid y correo electrónico para que no para sobrescribir ningún otro dato. */
            data = [
                Claves.Usuario.id: id,
                Claves.Usuario.email: email,
            ]
        }
        return data
    }
}
