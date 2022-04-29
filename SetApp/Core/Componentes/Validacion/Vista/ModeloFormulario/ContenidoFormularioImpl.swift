//
//  FormContentBuilder.swift
//  Validation
//
//  Created by Omar Bonilla Varela on 18/4/22.
//

import Foundation
import Combine

/* Esta clase tiene crea y realiza las validaciones de los componentes del formulario, esta clase se utiliza para facilitar el tratamiento de datos complejos como un datepicker */
/* ObservableObject podemos ver los cambios que ocurren en esta clase */
final class ContenidoFormularioImpl: ObservableObject  {
    
    //Almacenamos si es valido el formulario
    @Published var esValido = false
    
    /* Esta variable nos srive para indicar si el formulario completo es valido o no, lo ñadimos privada para que solo se puedad hacer cambios dentro de la clase, pero si serña visible para las otras clases */
    @Published private(set) var estado: FormularioEstado?
    
    init(){
        //Reseteamos las varible
        self.esValido = false
    }
    
    /* Contruir de esta forma los componentes del formulario permite a la vistas ser más dinámicas y escalables */
    //En esta variable declaramos nuestros componentes que queremos en el formulario
    private(set) var contenidoFormulario: [ComponenteFormulario] = [
        
        //Nombre
        TextFormComponent(id: .nombreCompleto,
                          placeholder: "Nombre Completo",
                          validaciones: [
                            
                            /* Elegimos las validaciones que queremos para cada componente */
                            //Validar nombre
                            GestionValidacionRegexImpl(
                                [
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreApellidos,
                                                            error: .personalizado(mensaje: "Formato de nombre completo incorrecto"))
                                ]
                            )
                            
                          ]),
        
        
        //Nombre de usuario
        TextFormComponent(id: .nombreUsuario,
                          placeholder: "Nombre usuario",
                          validaciones: [
                            
                            /* Elegimos las validaciones que queremos para cada componente */
                            //Validar nombre
                            GestionValidacionRegexImpl(
                                [
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreUsuarioCaracteresValidos,
                                                            error: .personalizado(mensaje: "El nombre de usuario debe empezar por una letra")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreUsuarioLongitud,
                                                            error: .personalizado(mensaje: "La longitud del nombre de usuario debe ser de entre 8 y 26 caracteres")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreUsuarioCorrecto,
                                                            error: .personalizado(mensaje: "Formato de nombre de usuario incorrecto"))
                                    
                                ]
                            )
                            
                          ]),
        
        //Email
        TextFormComponent(id: .email,
                          placeholder: "Email",
                          keyboardType: .emailAddress,
                          validaciones: [
                            
                            /* Elegimos las validaciones que queremos para cada componente */
                            //Validar nombre
                            GestionValidacionRegexImpl(
                                [
                                    ElementoFormularioRegex(patron: PatronesRegex.caracterNecesarioEmail,
                                                            error: .personalizado(mensaje: "Debes introducir este caracter @ en el correo electrónico")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.comprobarCorreo,
                                                            error: .personalizado(mensaje: "Formato de correo electrónico incorrecto"))
                                    
                                ]
                            )
                            
                          ]),
        
        //Password
        SecureTextFormComponent(id: .password,
                                placeholder: "Contraseña",
                                validaciones: [
                                    
                                    /* Elegimos las validaciones que queremos para cada componente */
                                    //Validar nombre
                                    GestionValidacionRegexImpl(
                                        [
                                            ElementoFormularioRegex(patron: PatronesRegex.unaMinuscula,
                                                                    error: .personalizado(mensaje: "La contraseña debe tener que haber una minúscula")),
                                            
                                            ElementoFormularioRegex(patron: PatronesRegex.unaMayuscula,
                                                                    error: .personalizado(mensaje: "La contraseña debe tener que haber una mayúscula")),
                                            
                                            ElementoFormularioRegex(patron: PatronesRegex.tresDigitos,
                                                                    error: .personalizado(mensaje: "La contraseña debe tener que haber tres dígitos")),
                                            
                                            ElementoFormularioRegex(patron: PatronesRegex.caracteresEspeciales,
                                                                    error: .personalizado(mensaje: "La contraseña debe tener un carcter especial, los permitidos son !@#$&*")),
                                            
                                            //Vañidar que tenga más de 9 caracteres
                                            ElementoFormularioRegex(patron: PatronesRegex.soloNueveCaracteres,
                                                                    error: .personalizado(mensaje: "La contraseña debe tener 9 carcateres")),
                                            
                                            //Validar que se haya cumplido todos los caracteres
                                            ElementoFormularioRegex(patron: PatronesRegex.comprobarPassword,
                                                                    error: .personalizado(mensaje: "Formato de contraseña incorrecto"))
                                            
                                        ]
                                    )
                                    
                                ]),
        //Fecha de nacimiento
        DateFormComponent(id: .dob,
                          mode: .date,
                          validaciones: [
                            // Validación para el tipo fecha
                            GestionValidacionDateImpl()
                          ]),
        
        //Botón
        ButtonFormItem(id: .submit,
                       titulo: "Siguiente")
    ]
    
    //Actualizar los valores de la matriz para saber cuando hay o no errores
    func actualizar(val: Any, in component: ComponenteFormulario) {
        /* Buscamos el primer componente de  la matriz que coincida con la identificacion del id no la identificacion del formulario */
        guard let index = contenidoFormulario.firstIndex(where: { $0.id == component.id }) else { return }
        contenidoFormulario[index].val = val
    }
    
    //Validamos si el formulario completo está correcto o no devolvemos si se ha validado correctamente el usuario
    func validacion() {
        
        let componentesFormulario = contenidoFormulario
            .filter { $0.idFormulario != .submit }
        
        //Recorremos todos los componentes de la matriz
        for component in componentesFormulario {
            
            //Recorremos las validaciones de la matriz
            for validator in component.validaciones {
                //Si hay un error
                if let error = validator.validar(component.val as Any) {
                    //Cambiamos el estado por el error producido
                    self.estado = .error(personalizado: error)
                    //En el momento que encontremos el error saldrá del bucle
                    return
                }
            }
        }
        
        /* Cuando el usuaria esté correctamente valiodado crearemos un usuario */
        if let nombrecompleto = componentesFormulario.first(where: { $0.idFormulario == .nombreCompleto })?.val as? String,
           let nombreUsuario = componentesFormulario.first(where: { $0.idFormulario == .nombreUsuario })?.val as? String,
           let email = componentesFormulario.first(where: { $0.idFormulario == .email })?.val as? String,
           let pasword = componentesFormulario.first(where: { $0.idFormulario == .password })?.val as? String,
           let dob = componentesFormulario.first(where: { $0.idFormulario == .dob })?.val as? Date {
            
            let nuevoUsuario =  UsuarioRegistro(nombreCompleto: nombrecompleto, nombreUsuario: nombreUsuario, sexo: "", fechaNacimiento: ParsearFecha.asString(fecha:dob), email: email, password: pasword)
            
            //Indicar que se ha validado
            self.estado = .validar(usuario: nuevoUsuario)
            
        }
        
    }
    
}
