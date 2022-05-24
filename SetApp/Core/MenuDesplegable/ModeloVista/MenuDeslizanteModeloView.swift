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
    case categorias
    case logout
    
    //Título de las acciones disponibles
    var titulo: String{
        //Añdimos que devuelva el nombre de las claves de LocalizedStringKey, posteriormente se hará el tratamiento para mostrar su valor
        switch self{
        case .perfil: return  "menuDesplegable-perfil"
        case .categorias: return  "menuDesplegable-categorias"
        case .logout: return "menuDesplegable-cerrarSesion"
        }
    }
    
    //Ícono de los títulos correspondientes
    var imagenNombre: String{
        switch self{
        case .perfil: return "person"
        case .categorias: return "list.bullet"
        case .logout: return "arrow.left.square"
        }
    }
}
