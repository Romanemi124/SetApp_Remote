//
//  ElementoFormularioRegex.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

import Foundation

struct ElementoFormularioRegex {
    //Patrón a seguir del elemento que se va a validar
    let patron: String
    //Se mostrará cada vez que hay un error
    let error: ValidarError
}

/* Se encargará de la gestión de las validaciones de los componentes del formulario */
protocol GestionValidacion {
    
    //Indicamos como opcional puesto que puede no tener errores
    func validar(_ val: Any) -> ValidarError?
}

// Regex Validator Manager
/* El objecto de esta estrucura es indicarnos si está bien o no los datos añadidod */
struct GestionValidacionRegexImpl: GestionValidacion {
    
    //Tenemos una matriz de las expresiones regulares para el formulario
    private let elementos: [ElementoFormularioRegex]
    
    init(_ elementos: [ElementoFormularioRegex]) {
        self.elementos = elementos
    }
    
    /* Validar según las expresiones regulares */
    func validar(_ val: Any) -> ValidarError? {
        
        //Castemos el string a una constante
        let val = (val as? String) ?? ""
        
        //Bucle que recorre las expresiones regulares
        for regexElemento in elementos {
            
            //NSRegularExpression(pattern: regexItem.pattern) identifica las expresiones regulares
            let regex = try? NSRegularExpression(pattern: regexElemento.patron)
            
            //NSRange evalua la logintud de la cadena
            let rango = NSRange(location: 0, length: val.count)
            
            //firstMatch evaluar si coincide
            /* Buscar la primera expresion regular si coincide sino coincide nos devolverá un nil y mostremos el error */
            if regex?.firstMatch(in: val, options: [], range: rango) == nil {
                
                //Devolvemos el error
                return regexElemento.error
                
            }
            
        }
      //En el caso que no encuentre nada significará que no hay ningún error de validación
        return nil
    }
}

/* Para validar la fecha de nacimiento */
struct GestionValidacionDateImpl: GestionValidacion {
    
    //Indicamos la edad mínima para registrarse
    private let edadLimite: Int = 18
    
    func validar(_ val: Any) -> ValidarError? {
        
        //Castear el valor, si no se pude nos mostrará un error
        guard let date = val as? Date else {
            return ValidarError.personalizado(mensaje: "No se ha podido pasar la fecha de nacimiento")
        }
        
        //Evalumos que el usuario debe ser mayor de 18 años
        if let calcularEdad = Calendar.current.dateComponents([.year], from: date, to: Date()).year,
           calcularEdad < edadLimite {
            
            //Devuelve el error si es menor de 18 años
            return ValidarError.personalizado(mensaje: "El usuario debe ser mayor de 18 para registrarse")
            
        }
        
        //En el caso que nos devuelva null, significa que es un fecha valida
        return nil
    }
}
