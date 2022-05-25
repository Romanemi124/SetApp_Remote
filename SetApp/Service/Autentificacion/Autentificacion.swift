//
//  Autentificacion.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import FirebaseFirestore
import FirebaseStorage

/* Clase encargada de la autentificación del usuario, iniciar sesión, registrarse y guardar crecdenciales de la sesión */
struct Autentificacion {
    
    // MARK: - Autentificación del usuario
    //Iniciar sesión, nos devolverá un error especifico si hay alguno, sino ninguno un booleano cuyo valor será verdadero
    /* Función para iniciar sesión añadiendo por parámetro el email y contraseña, en caso de error nos devolverá un error especifico de tipo EmailAutentificacionError, sino hay ninguno, un booleano cuyo valor será verdadero */
    static func autenticar(withEmail email :String,
                           password:String,
                           completionHandler:@escaping (Result<Bool, EmailAutentificacionError>) -> ()) {
        
        //Inciamos sesión con el email y la contraseña en usuarios registrados en Firebase
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            // NSError permite convertir el error a tipo AuthError, de esta forma resulatará más fácil tratar el error
            var newError:NSError
            
            //Si hay un error en el back-end
            /* if let error = error Esta estrucutura se denomina Optional binding,un tipo de vinculación opcional*, La condición de este if reside en que se pueda definir una constante apartir del valor que podría almacenar la variable opcional, caso contrario se ejecutaría el bloque else. Es decir, lo usa para verificar si el opcional ( erroren su caso) contiene un valor y, en caso afirmativo, para asignar ese valor a la constante vinculada ( en su caso) */
            /* -*La vinculación opcional nos permite verificar si un opcional contiene un valor y, si lo contiene, nos permite hacer que ese valor esté disponible en una variable.*/
            //Controlamos los errores al iniciar sesión
            if let err = error {
                
                //Casteamos e igualamos el error resultante a tipo NSError en el objecto newError
                newError = err as NSError
                
                //Clase en el que personalizaremos el error
                var authError:EmailAutentificacionError?
                
                //Tipos de errores que pueden ocurrir al autentificarnos
                switch newError.code {
                    //Tipo de error
                case 17009:
                    //Seleccionamos el tipo de error
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accoundDoesNotExist
                default:
                    authError = .unknownError
                }
                
                //Devolvemos el error
                completionHandler(.failure(authError!))
                
            } else {
                //Cuando no haya ningún error, el usuario ha iniciado sesión correctamente
                completionHandler(.success(true))
            }
        }
    }
    
    // MARK: - Crear usuario
    /* Función para registrar un usuario solo se almecenará en está función el el nombre completo, nombre de usuario, email, sexo ,la fechaNacimiento, foto de perfil y el id del usuario
     En caso de error nos devolverá un error de tipo Error, sino hay ninguno, un booleano cuyo valor será verdadero */
    static func crearUsuario(nombreCompleto: String, nombreUsuario: String, email:String,
                             password:String, sexo: String, fechaNacimiento: String, imageData:Data,
                             completionHandler:@escaping (Result<Bool,Error>) -> Void) {
        
        //Registramos el usuario según el email y contraseña añadida
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            //Comprobar si existe un error
            if let err = error {
                //Nos devuelve el error
                completionHandler(.failure(err))
                return
            }
            
            //Evaluamos si el usuario se ha registrado correctamente, en caso contrario saldrá de la función.
            guard let _ = authResult?.user else {
                completionHandler(.failure(error!))
                return
            }
            
            //Sino no hay ningún error nos guardará el usuario en un diccionario, para aseguramos que el id y el email sea diferente al usuario que se va registrar
            let data = UsuarioFireBase.dataDict(id: authResult!.user.uid, nombreCompleto: nombreCompleto, nombreUsuario: nombreUsuario, email: email, sexo: sexo, fechaNacimiento: fechaNacimiento, urlImagenPerfil: "")
            
            //Si hay algún error nos devolverá el error producido
            Store.subirDatosFireBase(data, id: authResult!.user.uid) { (result) in
                completionHandler(result)
            }
            
            /* Subir imagen de perfil */
            guard let userId = authResult?.user.uid else{return}
            let storageProfileUserId =  StorageService.storagePerfilId(idUsuario: userId)
            let metadata = StorageMetadata()
            //Tipo de dato que se va a almacenar
            metadata.contentType = "image/jpg"
            //Guardar la foto de perfil Storage de FireBase
            StorageService.guardarFotoPerfil(id: userId, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId)
            
            //Si el registro ha sido correcto nos devolverá un true
            completionHandler(.success(true))
            
        }
    }
    
    /* Buscar que no se repita el nombre de usuario */
    static func buscarNombreUsuario(withNombreUsuario nombreUsuario: String, completionHandler:@escaping (Result<Bool,Error>) -> Void){
        
        //whereField("nombreUsuario", isEqualTo: nombreUsuario) seleccionamos el campo que se va buscar
        Firestore.firestore().collection("usuarios").whereField("nombreUsuario", isEqualTo: nombreUsuario).getDocuments{ (resultado, error) in
            
            if let error = error {
                print("Debug Error: al buscar el usuario \(error.localizedDescription)")
            }else{
                //Si encuentra al usuario
                if (resultado!.documents.count > 0){
                    completionHandler(.success(true))
                    print("Debug: nombreUsuario encontrado")
                }else{
                    //No encuentra al usuario
                    completionHandler(.success(false))
                    print("Debug: nombreUsuario no encontrado")
                }
            }
        }
    }
    
    // MARK: - Modificar perfil
    //Modificar el perfil cuando el usuario eliga una foto nueva de perfil
    static func modificarUsuario( id:String, nombreCompleto: String,sexo: String, fechaNacimiento: String, imageData:Data,
                                  completionHandler:@escaping (Result<Bool,Error>) -> Void) {

        //Seleccionamos los datos a modificar
        let data = ["nombreCompleto" : nombreCompleto, "sexo" :sexo, "fechaNacimiento" : fechaNacimiento]
        
        //Si hay algún error nos devolverá el error producido
        Store.subirDatosFireBase(data, id: id) { (result) in
            completionHandler(result)
        }
        
        /* Subir imagen de perfil */
        let storageProfileUserId =  StorageService.storagePerfilId(idUsuario: id)
        let metadata = StorageMetadata()
        //Tipo de dato que se va a almacenar
        metadata.contentType = "image/jpg"
        //Guardar la foto de perfil Storage de FireBase
        StorageService.guardarFotoPerfil(id: id, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId)
        
        //Si el registro ha sido correcto nos devolverá un true
        completionHandler(.success(true))
        
    }
    
    //Modificar el perfil cuando el usuario no eliga una foto nueva de perfil
    static func modificarUsuarioSinImagen( id:String, nombreCompleto: String,sexo: String, fechaNacimiento: String,
                                  completionHandler:@escaping (Result<Bool,Error>) -> Void) {

        //Seleccionamos los datos a modificar
        let data = ["nombreCompleto" : nombreCompleto, "sexo" :sexo, "fechaNacimiento" : fechaNacimiento]
        
        //Si hay algún error nos devolverá el error producido
        Store.subirDatosFireBase(data, id: id) { (result) in
            completionHandler(result)
        }
        
        //Si el registro ha sido correcto nos devolverá un true
        completionHandler(.success(true))
        
    }

    
    // MARK: - Cerrar sesión
    /* Función para cerrar sesión
     En caso de error nos devolverá un error de tipo Error, sino hay ninguno, un booleano cuyo valor será verdadero */
    static func cerrarSesion(completion: @escaping (Result<Bool, Error>) -> ()) {
        //Obtenemeos la autentificación
        let auth = Auth.auth()
        //Comprobamos si hay algún error
        do {
            //Intentamos cerrar sesión
            try auth.signOut()
            completion(.success(true))
        } catch let err {
            completion(.failure(err))
        }
    }
    
    // MARK: - Cambiar de contraseña
    /* Cambiar de contraseña para ello se enviará al email que se pase por parametro un formulario para el cambio
     En caso de error nos devolverá un error de tipo Error, sino hay ninguno, un booleano cuyo valor será verdadero */
    static func cambiarPassword(email:String, resetCompletion:@escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                resetCompletion(.failure(error))
            } else {
                resetCompletion(.success(true))
            }
        }
        )}
    
    // MARK: - Borrar usuario
    enum ProviderType: String {
        case password
    }
    
    //Obtener el provedor que se ha a utilizar para la autentificación, en proximás se utilizarán distintos provedores como Apple o Google
    static func getProviders() -> [ProviderType] {
        //Obtenemos el provedor
        var providers:[ProviderType] = []
        //Obtenemos el usuario que ha iniciado sesión
        if let user = Auth.auth().currentUser {
            //Recorremos el array de provedores
            for data in user.providerData {
                //Elegimos el provedor
                if let providerType = ProviderType(rawValue: data.providerID) {
                    providers.append(providerType)
                }
            }
        }
        return providers
    }
    
    //Reautentificación del usuario, se utiliazará parq borrar el usuario
    static func reautenticacionConPassword(password: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        //Obtenemos el usuario que ha iniciado sesión
        if let user = Auth.auth().currentUser {
            //Obtenemos las credenciales user.email ?? "" puesto que con las credenciales con Apple al poser FaceID es otro tratamiento
            let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
            //Reautenticamos el usuario
            user.reauthenticate(with: credential) { _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
    //Eliminar el usuario
    static func eliminarUsuario(completion: @escaping (Result<Bool,Error>) -> Void) {
        //Obtenemos el usuario que ha iniciado sesión
        if let user = Auth.auth().currentUser {
            //Borramos el usuario
            user.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
}
