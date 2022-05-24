//
//  Validacion.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation


/* Sirve para la validación de los datos del usuario */
struct Validacion {
    
    var nombreCompleto: String = ""
    var nombreUsuario: String = ""
    var fechaNacimiento: Date  = Date()
    var email: String = ""
    var password: String = ""
    var confirmarPassword: String = ""
    var fotoPerfil: Data = Data()
    
    // MARK: - Comprobar Validación
    
    //Comprobar que las 2 contraseñas escritas son las mismas
    func passwordsCoinciden(_coincidenPw:String) -> Bool {
        return _coincidenPw == password
    }
    
    //Valida si el campo está vacío
    func estaVacio(_field:String) -> Bool {
        return _field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    //Validar si hay una imagen en la foto de perfil
    func estaValidaFotoPerfil(_fotoPerfil: Data) -> Bool{
        if !fotoPerfil.isEmpty{
            return  true
        }else{
            return false
        }
    }
    
    /* PatronesRegex obtenemos las expresiones reguales necesario */
    //Validar nombre y apellidos
    func estaValidoNombreCompleto(_nombreCompleto: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest =  NSPredicate(format: "SELF MATCHES %@",
                                        PatronesRegex.comprobarNombreApellidos)
        return passwordTest.evaluate(with: nombreCompleto)
    }
    
    //Validamos el nombre de usuario
    func estaValidoNombreUsuario(_nombreUsuario: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       PatronesRegex.comprobarNombreUsuario)
        return passwordTest.evaluate(with: nombreUsuario)
    }
    
    //Función para validar edad
    func validarEdad(_ val: Date) -> String? {
        
        //Indicamos la edad mínima para registrarse
        let edadLimite: Int = 18
        
        //Castear el valor, si no se pude nos mostrará un error
        guard let date = val as? Date else {
            return  "No se ha podido pasar la fecha de nacimiento"
        }
        
        //Evalumos que el usuario debe ser mayor de 18 años
        if let calcularEdad = Calendar.current.dateComponents([.year], from: date, to: Date()).year,
           
            calcularEdad < edadLimite {
            
            //Devuelve el error si es menor de 18 años
            return "El usuario debe ser mayor de 18 para registrarse"
            
        }
        //En el caso que nos devuelva null, significa que es un fecha valida
        return nil
        
    }
    
    //Validamos la edad devolviendo un booleano
    func estaValidaEdad(_Edad: Date)->Bool{
        
        if  validarEdad(fechaNacimiento) == nil{
            return true
        } else {
            return false
        }
        
    }
    
    //Validamos si el email cumple el formato correcto
    func estaValidoEmail(_email: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       PatronesRegex.comprobarCorreo)
        return passwordTest.evaluate(with: email)
    }
    
    //Validamos si al contraseña cumple el formato correcto
    func estaValidoPassword(_password: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       PatronesRegex.comprobarPassword)
        
        return passwordTest.evaluate(with: password)
    }
    
    // MARK: -  Botones estado
    /* Los botones se podrán activar ucando se complete la vlaidación de forma correcta */
    
    //Validamos si se ha completo el registro correctamente
    var estaRegistrarseCompletado:Bool  {
        //Devolverá falso si alguno de los campos es incorrecto
        
        if  !estaValidaFotoPerfil(_fotoPerfil: fotoPerfil) ||
                !estaValidoNombreCompleto(_nombreCompleto: nombreCompleto) ||
                !estaValidoNombreUsuario(_nombreUsuario: nombreUsuario) ||
                !estaValidaEdad(_Edad: fechaNacimiento) ||
                !estaValidoEmail(_email: email) ||
                !estaValidoPassword(_password: password) ||
                !passwordsCoinciden(_coincidenPw: confirmarPassword){
            return false
        }
        return true
    }
    
    //Validamos si se ha escrito en los campos para iniciar sesión
    var estaIniciarSesionCompletado:Bool {
        if estaVacio(_field: email) ||
            estaVacio(_field: password) {
            return false
        }
        return true
    }
    
    // MARK: - Validación errores
    
    //Validar si hay una imagen en la foto de perfil
    var validaFotoPerfil: String{
        if estaValidaFotoPerfil(_fotoPerfil: fotoPerfil){
            return ""
        }else{
            return "validacion-clase-foto"
        }
    }
    
    //Validación del nombre
    var validoTextoNombreCompleto: String {
        
        //Validamos que el nombre completo no sea mayor de <= 50
        if estaValidoNombreCompleto(_nombreCompleto: nombreCompleto) && nombreCompleto.count <= 50{
            
            return ""
            
        } else {
            return "validacion-clase-nombreCompleto"
        }
        
    }
    
    //Validación del nombre
    var validoTextoNombreUsuario: String {
        if estaValidoNombreUsuario(_nombreUsuario: nombreUsuario){
            return ""
        } else {
            return "validacion-clase-nombreUsuario"
        }
        
    }
    
    //Validar edad
    var validaEdad: String {
        //Si es diferente de nulo significa que la edad no es superior a 18
        if  estaValidaEdad(_Edad: fechaNacimiento){
            return ""
        } else {
            return "validacion-clase-edad"
            
        }
    }
    
    //Validación del email
    var validoTextoEmail:String {
        if estaValidoEmail(_email: email) {
            return ""
        } else {
            return "validacion-clase-email"
        }
    }
    
    //Validación de la contraseña
    var validoTextoPassword:String {
        if estaValidoPassword(_password: password) {
            return ""
        } else {
            return "validacion-clase-password"
        }
    }
    
    //Validación de confirmar la contraseña
    var validoTextoConfirmarPassword: String {
        if passwordsCoinciden(_coincidenPw: confirmarPassword) {
            return ""
        } else {
            return "validacion-clase-password-coincidencia"
        }
    }
}

class ValidacionEditarPerfil {
    
    // MARK: - Comprobar Validación
    /* PatronesRegex obtenemos las expresiones reguales necesario */
    //Validar nombre y apellidos
    func estaValidoNombreCompleto(nombreCompleto: String) -> Bool {
        // Password must be 8 chars, contain a capital letter and a number
        let passwordTest =  NSPredicate(format: "SELF MATCHES %@",
                                        PatronesRegex.comprobarNombreApellidos)
        return passwordTest.evaluate(with: nombreCompleto)
    }
    
    //Función para validar edad
    func validarEdad(_ val: Date) -> String? {
        
        //Indicamos la edad mínima para registrarse
        let edadLimite: Int = 18
        
        //Castear el valor, si no se pude nos mostrará un error
        guard let date = val as? Date else {
            return  "No se ha podido pasar la fecha de nacimiento"
        }
        
        //Evalumos que el usuario debe ser mayor de 18 años
        if let calcularEdad = Calendar.current.dateComponents([.year], from: date, to: Date()).year,
           
            calcularEdad < edadLimite {
            
            //Devuelve el error si es menor de 18 años
            return "El usuario debe ser mayor de 18 para registrarse"
            
        }
        //En el caso que nos devuelva null, significa que es un fecha valida
        return nil
    }
    
    //Validamos la edad devolviendo un booleano
    func estaValidaEdad(fechaNacimiento: Date)->Bool{
        if  validarEdad(fechaNacimiento) == nil{
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Validación errores

    //Validación de texto error nombre completo
    func validarTextoNombreCompleto(nombreCompleto2: String) -> String {
        //Validamos que el nombre completo no sea mayor de <= 50
        if estaValidoNombreCompleto(nombreCompleto: nombreCompleto2) && nombreCompleto2.count <= 50{
            return ""
        } else {
            return "validacion-clase-nombreCompleto"
        }
    }

    //Validacion de fecha de nacimiento
    func validarTextoFechaNacimiento(fechaNacimiento2: Date) -> String {
        //Si es diferente de nulo significa que la edad no es superior a 18
        if  estaValidaEdad(fechaNacimiento: fechaNacimiento2){
            return ""
        } else {
            return "validacion-clase-edad"
            
        }
    }
    
    // MARK: - Validación final de editar perfil
    /* Permite actualizar el perfil si el resultado es verdadero */
    func actualizarPerfil(nombreCompleto2: String, fechaNacimiento2: Date)->Bool{
        
        //Si alguno de ellos no es verdadero
        if !estaValidoNombreCompleto(nombreCompleto: nombreCompleto2) || !estaValidaEdad(fechaNacimiento: fechaNacimiento2){
            return false
        }
        return true
    }
    
    //Sustuir en primer lugar el sexo elegido por el usuario
    func sexoPredeterminado(sexoUsuario:String) -> [String]{
       
        var sexosOrden = [""]
        
        if sexoUsuario == "Hombre"{
            sexosOrden = ["Hombre", "Mujer", "Otro"]
        }
        
        if sexoUsuario == "Mujer"{
            sexosOrden = ["Mujer", "Hombre", "Otro"]
        }
        
        if sexoUsuario == "Otro"{
            sexosOrden = ["Otro", "Hombre", "Mujer"]
        }
        
        return sexosOrden
    }
    
    //Buscar el sexo en el array
    func find(value searchValue: String, in array: [String]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value == searchValue {
                return index
            }
        }
        
        return nil
    }
}

