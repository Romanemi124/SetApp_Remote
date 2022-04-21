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
    
    /* Esta variable nos srive para indicar si el formulario completo es valido o no, lo ñadimos privada para que solo se puedad hacer cambios dentro de la clase, pero si serña visible para las otras clases */
    @Published private(set) var estado: FormularioEstado?
    
    /* Contruir de esta forma los componentes del fomrulario permite a la vistas ser más dinámicas y escalables */
    
    //En esta variable declaramos nuestros componentes que queremos en el formulario
    private(set) var componenteFormulario: [ComponenteFormulario] = [
        
            //Nombre
        TextFormComponent(id: .nombre,
                             placeholder: "Nombre",
                             validaciones: [

                                /* Elegimos las validaciones que queremos para cada componente */
                                GestionValidacionRegexImpl(
                                   [
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreApellidos,
                                                     error: .personalizado(mensaje: "Formato de nombre inválido"))
                                   ]
                               )

                             ]),
           //Apellidos
           TextFormComponent(id: .apellido,
                             placeholder: "Apellidos",
                             validaciones: [

                                GestionValidacionRegexImpl(
                                   [
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreApellidos,
                                                     error: .personalizado(mensaje: "Invalid Last Name entered"))
                                   ]
                               )

                             ]),
           
           //Nombre de usuario
           TextFormComponent(id: .nombreUsuario,
                             placeholder: "Nombre usuario",
                             validaciones: [

                                GestionValidacionRegexImpl(
                                   [
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreUsuarioCaracteresValidos,
                                              error: .personalizado(mensaje: "Caracter invalido")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreUsuarioLongitud,
                                              error: .personalizado(mensaje: "La longitud del nombre de usuario debe ser de entre 7 y 23 caracteresw")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.nombreUsuarioCorrecto,
                                                     error: .personalizado(mensaje: "Nombre usuario invalido"))
                                   ]
                               )

                             ]),
           
           //Email
           TextFormComponent(id: .email,
                             placeholder: "Email",
                             keyboardType: .emailAddress,
                             validaciones: [

                                GestionValidacionRegexImpl(
                                   [
                                    ElementoFormularioRegex(patron: PatronesRegex.caracterNecesarioEmail,
                                                     error: .personalizado(mensaje: "Invalid Email missing @")),
                                       
                                    ElementoFormularioRegex(patron: PatronesRegex.comprobarCorreo,
                                                     error: .personalizado(mensaje: "La dirección de correo es incorrecta"))
                                   ]
                               )


                             ]),
           
           //Password
           SecureTextFormComponent(id: .password,
                             placeholder: "Password",
                                   validaciones: [

                                GestionValidacionRegexImpl(
                                   [
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.unaMinuscula,
                                                     error: .personalizado(mensaje: "Tiene que haber una Minuscula")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.unaMayuscula,
                                                     error: .personalizado(mensaje: "Tiene que haber una Mayuscula")),
                                    
                                    ElementoFormularioRegex(patron: PatronesRegex.tresDigitos,
                                                     error: .personalizado(mensaje: "Tiene que haber tres Digitos")),
                                      
                                    ElementoFormularioRegex(patron: PatronesRegex.caracteresEspeciales,
                                                     error: .personalizado(mensaje: "Tiene que haber minimo un carcter especial, los permitidos son !@#$&*")),
                                    
                                    //Vañidar que tenga más de 9 caracteres
                                    ElementoFormularioRegex(patron: PatronesRegex.soloNueveCaracteres,
                                                     error: .personalizado(mensaje: "Tiene que ser 9 characters")),
                                    
                                    //Validar que se haya cumplido todos los caracteres
                                    ElementoFormularioRegex(patron: PatronesRegex.comprobarCorreo,
                                                     error: .personalizado(mensaje: "Contraseña incorrecta revisa los caracteres añdidos"))
                                    
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
                          titulo: "Confirmar")
    ]
 
    //Actualizar los valores de la matriz para saber cuando hay o no errores
    func actualizar(val: Any, in component: ComponenteFormulario) {
        /* Buscamos el primer componente de  la matriz que coincida con la identificacion del id no la identificacion del formulario */
        guard let index = componenteFormulario.firstIndex(where: { $0.id == component.id }) else { return }
        componenteFormulario[index].val = val
    }
    
    //Validamos si el formulario completo está correcto o no
    func validar() {
        
        let componentesFormulario = componenteFormulario
            .filter { $0.idFormulario != .submit }
        
        //Recorremos todos los componentes de la matriz
        for componente in componentesFormulario {
            
            //Recorremos las validaciones de la matriz
            for validator in componente.validaciones {
                //Si hay un error
                if let error = validator.validar(componente.val as Any) {
                    //Cambiamos el estado por el error producido
                    self.estado = .error(personalizado: error)
                    //En el momento que encontremos el error saldrá del bucle
                    return
                }
            }
        }
        
       /* Cuando el usuaria esté correctamente valiodado crearemos un usuario */
        if let nombre = componentesFormulario.first(where: { $0.idFormulario == .nombre })?.val as? String,
           let apellido = componentesFormulario.first(where: { $0.idFormulario == .apellido })?.val as? String,
           let nombreUsuario = componentesFormulario.first(where: { $0.idFormulario == .nombreUsuario })?.val as? String,
           let email = componentesFormulario.first(where: { $0.idFormulario == .email })?.val as? String,
           let pasword = componentesFormulario.first(where: { $0.idFormulario == .password })?.val as? String,
           let dob = componentesFormulario.first(where: { $0.idFormulario == .dob })?.val as? Date {
            
           let nuevoUsuario = UsuarioRegistro(nombre: nombre, apellido: apellido, nombreUsuario: nombreUsuario, sexo:"" , fechaNacimiento: ParsearFecha.asString(fecha:dob), email: email, password: pasword)
            
            //Indicar que se ha validado
            self.estado = .validar(usuario: nuevoUsuario)
        }
    }
}
