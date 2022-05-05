//
//  Extensions.swift
//  SetApp
//
//  Created by Emilio Roman on 3/5/22.
//

import Firebase

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            throw NSError()
        }
        
        return dictionary
    }
}

extension Decodable {
    
    init(fromDictionary: Any) throws {
        
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

extension String {
    
    func splitString() -> [String] {
        
        var stringArray: [String] = []
        let trimmed = String(self.filter { !" \n\t\r".contains($0)})
        
        for (index, _) in trimmed.enumerated() {
            
            let prefixIndex = index + 1
            let substringPrefix = String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(substringPrefix)
        }
        
        return stringArray
    }
}

extension Error {
    
    var authErrorValue : String {
        
        let errorcode = AuthErrorCode(rawValue: self._code)
        return errorcode!.stringValue
    }
}

extension AuthErrorCode {
    
    var stringValue: String {
        
        switch self {
        case .emailAlreadyInUse:
            return "Usuario existente! por favor inicie sesión"
        case .invalidEmail:
            return "Por favor ingrese un email correcto"
        case .userNotFound:
            return "Cuenta no encontrada, por favor regístrese"
        case .networkError:
            return "Error de conexión"
        case .wrongPassword:
            return "Contraseña incorrecta"
        case .weakPassword:
            return "La contraseña debe tener al menos 6 caracteres"
        default:
            print("Error")
            return "Por favor inténtelo más tarde"
        }
    }
}
