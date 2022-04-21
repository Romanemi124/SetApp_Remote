//
//  PatronesRegex.swift REGEX -> Expresiones regulares
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

import Foundation

/* Lista de las expresiones regulares que se van utilizar para validar el formulario */
enum PatronesRegex {
    
    /* Nombres y Apellidos */
    /* Validar nombres y Apellidos en español con tildes, ñ y doble nombre */
    static let nombreApellidos = "^[a-zA-ZáéíóúüñÁÉÍÓÚÑñ]+(([ -][a-zA-Z ])?[a-zA-ZáéíóúüñÁÉÍÓÚÑñ]*)*$"
    
    /* Nombre de usuario */
    /* - Un nombre de usuario válido debe comenzar con un alfabeto así, [A-Za-z].
     - Todos los demás caracteres pueden ser letras, números o guiones bajos, [A-Za-z0-9_].
     - Dado que la restricción de longitud se dio como 8-30 y ya habíamos arreglado el primer carácter, le damos {7,29}. */
    //Caracteres validos
    static let nombreUsuarioCaracteresValidos = ".*[A-Za-z][A-Za-z0-9_]*."
    //Longitud mínima y máxima
    static let nombreUsuarioLongitud = "\\w{7,23}"
    //Comprobar que el nombre de usuario es correcto,gracias a esto comprobamos que el usuario cumpla con la validación
    static let nombreUsuarioCorrecto = "^[A-Za-z][A-Za-z0-9_]{7,23}$"
    
    /* Email */
    //Necesario añdir ese caracter al email
    static let caracterNecesarioEmail = ".*[@].*"
    //Comprobar el email completo
    static let comprobarCorreo = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    /* Contraseña */
    /* - 1 Mayúscula
     - 1 Minúscula
     - 3 Dígitos
     - 1 Caracter especial (solo validos: !@#$&*)
     - Longitud de la contraseña debe ser 9 */
    // 1 Mayúscula
    static let unaMayuscula = "(?=.*[A-Z])"
    // 1 Minúscula
    static let unaMinuscula = "(?=.*[a-z])"
    // 3 Dígitos
    static let tresDigitos = "(?=.*[0-9].*[0-9].*[0-9])"
    // 1 Caracter especial (solo validos: !@#$&*)
    static let caracteresEspeciales = "(?=.*[!@#$&*])"
    // Longitud de la contraseña 9
    static let soloNueveCaracteres = "^.{9,}"
    //Comprobación contraseña entera
    static let comprobarPassword = "^[A-Za-z0-9!@#$&*]{9}$"
   
}
