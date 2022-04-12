//
//  ParsearFecha.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 11/4/22.
//

import Foundation

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
    
}
