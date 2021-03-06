//
//  Extension.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import Foundation

/* Convertir los usuarios en un diccionario */
extension Encodable{
    
    //Realizar un diccionario de los usuarios
    func asDictionary() throws -> [String: Any]{
        
        let data =  try JSONEncoder().encode(self)
        
        guard  let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else{ throw NSError()}
        
        return dictionary
    }
}

/* Pasar del diccianario a objectos Usuarios */
extension Decodable{
    init(fromDictionary: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self =  try decoder.decode(Self.self, from: data)
    }
    
}
//Dividir la cadena para que nos permita ignorar espacios blanco y saltos de línea
extension String {
    
    func splitString()-> [String]{
        
        var stringArray: [String] = []
        
        //Permite ignorar espacios blanco y saltos de línea
        let trimmed = String(self.filter{!" \n\t\r".contains($0)})
        
        for (index, _) in trimmed.enumerated(){
            
            let prefixIndex =  index+1
            
            let substringPrefix = String(trimmed.prefix(prefixIndex)).lowercased()
            
            stringArray.append(substringPrefix)
        }
        
        return stringArray
        
    }
    
    //Borrar los espacios en blanco
    func removeWhiteSpace() -> String{
        return components(separatedBy: .whitespaces).joined()
    }
    
}


//Para mostrar las publicaciones en el perfil por orden de fecha
extension Date {
    
    func timeAgo() -> String {
        
        let formatter = DateComponentsFormatter()
        
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    }
}
