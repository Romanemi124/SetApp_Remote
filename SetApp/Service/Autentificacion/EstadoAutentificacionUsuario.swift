//
//  EstadoUsuario.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

import Foundation
import FirebaseAuth

/* Esta clase sirve para indicar el estado de autentificación del usuario, si está o no registrado */
class EstadoAutentificacionUsuario: ObservableObject {
    
    /* Listado de los posibles casos de autentificación del usuario */
    enum EstadoAutentificacion {
        case indefinido, iniciarSesion, cerrarSesion
    }
    
    //Variable para acceder al estado de autentificación del usuario
    @Published var estaUsuarioAutentificado: EstadoAutentificacion = .indefinido
    //Guarda los datos del usuario autentificado
    @Published var usuario: UsuarioFireBase = .init(id: "", nombreCompleto: "", nombreUsuario: "", email: "", sexo: "", fechaNacimiento: "", urlImagenPerfil: "")
    
    //Variable que almacena los cambios en el estado de autentificación del usuario
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    /* Función para saber el estado de autentificación del usuario  */
    func configuracionFireBaseCambioEstado() {
        
        //Escucha los cambios en la sesión del usuario
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (_, user) in
            
            //Validamos si el usuario existe, si no existe nos dirgirará aregistrarnos
            guard let user = user else {
                self.estaUsuarioAutentificado = .cerrarSesion
                return
            }
            
            //Si el usuario existe se supondrá que el usuario a iniciado sesión
            self.estaUsuarioAutentificado = .iniciarSesion
        
            //Recuperamos los datos del usuario
            Store.recuperarUsuarioFB(id: user.uid) { (result) in
                switch result {
                //En el caso que haya algún error nos imprimirá por consola el tipo de error
                case .failure(let error):
                    print(error.localizedDescription)
                //En el caso que no haya ningún error guardaremos el usuario obtenido de FireBase en la variable usuario, de está forma puesto que se trata el usuario de un objecto de entorno podremos obtener sus datos en las demás vistas
                case .success(let user):
                    self.usuario = user
                }
            }
            
        })
        
    }
    
}
