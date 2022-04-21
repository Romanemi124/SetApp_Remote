//
//  UsuarioFormulario.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

/* Esta clase la vamos a utilizar para el formulario puesto que si un usuario interrumpe el registro, controlará que no se registre hasta que lo haga de forma correcta
 Un usuario que no se ha registrado correctamente es aquel que le falta algún dato en el registro, como por ejemplo la foto de perfil */
import Foundation

class UsuarioFormulario: ObservableObject{
    
    @Published var user : UsuarioRegistro?
    @Published var usuarioValidado : Bool = false
    
    /* Inicializamos la clase */
    init(){
        print("DEBUG: USUARIO VALIDADO \( usuarioValidado)")
    }
    
    /* Guardar los datos del usuario validado */
    func guardarDatosPersonales(withUsuarioRegistro nombre: String, apellido:String, nombreUsuario:String, sexo:String, fechaNacimiento:String, email:String, password: String){
        
        /* Añadimos los datos del formulario al usuario */
        let usuarioRegistrar: UsuarioRegistro = UsuarioRegistro(nombre: nombre, apellido: apellido, nombreUsuario: nombreUsuario, sexo: sexo, fechaNacimiento: fechaNacimiento, email: email, password: password)
        
        /* Desempaquetamos el opcional */
        guard var usuario = self.user else{ return }
        
        /* Igualamos el usuario registrado con el usuario desempaquetado */
        usuario = usuarioRegistrar
        
        print(usuario.nombre)
        print(usuario.apellido)
        print(usuario.fechaNacimiento)
        print(usuario.sexo)
        print(usuario.email)
        print(usuario.password)
         
        /* Igualamos a la variable de la clase */
        self.user = usuario
        
    }
    /* Esta función nos va servir para validar el usuario cuando se hay relaizado las validaciones, de esta forma nos podremos ir a la vista elegir foto de perfil */
    func validarUsuario(){
        
        /* Indicamos que se ha validado */
        self.usuarioValidado = true
    }
    
    /* Reseteamos los valores de las variables para que no aparezcan en un nuevo registro los datos del usuario anterior*/
    func resetearUsuario(){
        //Vaciamos los datos del objecto
        self.user = nil
        //Quitmaos la validación del usuario
        self.usuarioValidado = false
    }
    
}
