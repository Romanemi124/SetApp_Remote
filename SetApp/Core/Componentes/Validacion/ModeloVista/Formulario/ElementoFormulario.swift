//
//  ElementoFormulario.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

import Foundation

import Foundation
import UIKit
import SwiftUI

/* Esta es la clase padre de la cual los compomenetes como los textfield, datePicker y botones serán las que herederán la clase */
/* Esta clase esta clase se utiliza para facilitar el tratamiento de datos complejos como un datepicker y luego sus validaciones correspondientes */

/* protocol Los protocolos proporcionan un modelo para los métodos, las propiedades y otras funciones de requisitos. Simplemente se describe como un esqueleto de métodos o propiedades en lugar de una implementación. */
/* Cada elemento del formulario implementará esta estructura */
protocol ElementoFormulario {
    /* Para crear un indentificador único a cada elemento del formulario. Se necesita un id para luego la gestión de eventos, de esta forma, podemos identificar los campos incorrectos */
    var id: UUID { get }
    /* Elegimos el tipo de componente que será el elemento del formulario  */
    var idFormulario: CamposFormulario { get }
    /* Guardaremos las validaciones que se hace del componente  */
    var validaciones: [GestionValidacion] { get }
    /* Para que los componentes tengan valor, pero lo indicamos como optional para que no sea necesario añadir un valor a un componente como un botón */
    var val: Any? { get }
}

/* Lista con los diferentes componentes que podemos añadir al formulario */
enum CamposFormulario: String, CaseIterable {
    case nombreCompleto
    case nombreUsuario
    case email
    case password
    case dob
    case submit
}

/* Creamos la clase contendrá los componentes del formulario */
class ComponenteFormulario: ElementoFormulario, Identifiable {
    
    let id = UUID()
    let idFormulario: CamposFormulario
    var validaciones: [GestionValidacion]
    var val: Any?
    
    //Constructor de la clase
    init(_ id: CamposFormulario,
         validaciones: [GestionValidacion] = []) {
        self.idFormulario = id
        self.validaciones = validaciones
    }
}

/* Añadimos final a las clases para que no se pueda heredar a otras clases */
/* Esta clase configuramaos los campos de textos del formulario */
final class TextFormComponent: ComponenteFormulario {
   
    //Ayuda indicar el tipo de campo
    let placeholder: String
    //Indicar el tipo de teclado
    let keyboardType: UIKeyboardType
 
    init(id: CamposFormulario,
        placeholder: String,
        // keyboardType: UIKeyboardType = .default elegimos el tipo de teclado que queremos para los campos de texto
        keyboardType: UIKeyboardType = .default,
        //Indicamos las validaciones del componente, le daremos de forma predeterminado una matriz vacía, al añadirlo vacío podemos omitir las validaciones de ciertos componentes del formulario, de esta forma elegimos el tipo de validaciones que queremos para cada componente
         validaciones: [GestionValidacion] = []) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id, validaciones: validaciones)
    }
}

/* Para el campo contraseña */
final class SecureTextFormComponent: ComponenteFormulario {
   
    let placeholder: String
    let keyboardType: UIKeyboardType
 
    init(id: CamposFormulario,
        placeholder: String,
        // keyboardType: UIKeyboardType = .default elegimos el tipo de teclado que queremos para los campos de texto
        keyboardType: UIKeyboardType = .default,
        //Indicamos las validaciones del componente, le daremos de forma predeterminado una matriz vacía, al añadirlo vacío podemos omitir las validaciones de ciertos componentes del formulario, de esta forma elegimos el tipo de validaciones que queremos para cada componente
         validaciones: [GestionValidacion] = []) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id, validaciones: validaciones)
    }
}

/* Esta clase configuramos el calendario donde añadiremos las fechas */
final class DateFormComponent: ComponenteFormulario {

    let mode: DatePickerComponents
    
    init(id: CamposFormulario,
         mode: DatePickerComponents,
         validaciones: [GestionValidacion] = []) {
        self.mode = mode
        super.init(id, validaciones: validaciones)
    }
}


/* Esta clase configurmaos el botón del formulario */
final class ButtonFormItem: ComponenteFormulario {

    let titulo: String
    
    init(id: CamposFormulario,
         titulo: String) {
        self.titulo = titulo
        super.init(id)
    }
}

