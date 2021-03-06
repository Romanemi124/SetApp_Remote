//
//  ParsearFecha.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 11/4/22.
//

import Foundation

/* Clase que se usa para almacenar la fecha de nacimiento en Firebase según estructura*/
class ParsearFecha{
    
    //Método para pasar de Date a String con un formato de fecha
    static func asString(fecha: Date) -> String{
        //Cremos un objecto DateFormatter para elegir el formato de fecha
        let dateFormatter = DateFormatter()
        //Indicamos el formato de fecha querido
        dateFormatter.dateFormat = "MMM d, yyyy"
        //Pasamos de Date a String
        return dateFormatter.string(from: fecha)
    }
    
    //Método para pasar de String a Date con un formato de fecha
    static func asDate(fecha: String) -> Date?{
        //Cremos un objecto DateFormatter para elegir el formato de fecha
        let dateFormatter = DateFormatter()
        //Indicamos el formato de fecha querido
        dateFormatter.dateFormat = "MMM d, yyyy"
        //Pasamos de String a Date
        return dateFormatter.date(from: fecha)
    }
}
