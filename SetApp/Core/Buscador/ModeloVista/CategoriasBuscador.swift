//
//  CategoriasBuscador.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import Foundation

struct CategoriasBuscador: Identifiable {
    var id = UUID().uuidString
    var nombreCategoria: String
    var artwork: String
}

var categorias = [
    
    CategoriasBuscador(nombreCategoria: "Monitor", artwork: "monitor"),
    CategoriasBuscador(nombreCategoria: "Teclado", artwork: "teclado"),
    CategoriasBuscador(nombreCategoria: "Ratón", artwork: "raton"),
    CategoriasBuscador(nombreCategoria: "Componentes PC", artwork: "pc"),
    
    /*
     CategoriasBuscador(nombreCategoria: "Auriculares", artwork: "auriculares"),
     CategoriasBuscador(nombreCategoria: "Silla", artwork: "sillas"),
     CategoriasBuscador(nombreCategoria: "Mesa", artwork: "desk"),
     CategoriasBuscador(nombreCategoria: "Webcam/Cámaras Web", artwork: "camera"),
     CategoriasBuscador(nombreCategoria: "Altavoces", artwork: "altavoz"),
     CategoriasBuscador(nombreCategoria: "Micrófonos", artwork: "microfono"),
     CategoriasBuscador(nombreCategoria: "Vr", artwork: "vr"),
     CategoriasBuscador(nombreCategoria: "Componentes PC", artwork: "pc"),
     CategoriasBuscador(nombreCategoria: "Gamepads/Joysticks", artwork: ""),
     CategoriasBuscador(nombreCategoria: "Impresoras", artwork: ""),
     CategoriasBuscador(nombreCategoria: "Tablet", artwork: ""),
     CategoriasBuscador(nombreCategoria: "Accesorio", artwork: ""),
     CategoriasBuscador(nombreCategoria: "Almacenamiento", artwork: ""),
     CategoriasBuscador(nombreCategoria: "Software", artwork: ""),
     */
]

