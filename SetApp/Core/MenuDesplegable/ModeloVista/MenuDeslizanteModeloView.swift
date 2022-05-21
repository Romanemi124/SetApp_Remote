//
//  MenuDeslizanteModeloView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import Foundation
import SwiftUI

//Acciones disponibles en el menu deslizante
enum MenuDeslizanteModeloView: Int, CaseIterable{
    
    //Opciones de las acciones disponibles
    case perfil
//    case listas
//    case guardados
    case logout
    
    //Título de las acciones disponibles
    var titulo: String{
        switch self{
        case .perfil: return  "Perfil"
//        case .listas: return  "Listas"
//        case .guardados: return  "Guardados"
        case .logout: return "Cerrar sesión"
        }
    }
    
    //Ícono de los títulos correspondientes
    var imagenNombre: String{
        switch self{
        case .perfil: return  "person"
//        case .listas: return  "list.bullet"
//        case .guardados: return  "bookmark"
        case .logout: return "arrow.left.square"
        }
    }
}
