//
//  CategoriasBuscador.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import Foundation

//Estructura donde se van a reflejar las distintas categorías que puede tener un componente
struct CategoriasBuscador: Identifiable {
    var id = UUID().uuidString
    var nombreCategoria: String
    var artwork: String
    var fondo: String
}

var categorias = [
    
    CategoriasBuscador(nombreCategoria: "Monitor", artwork: "monitorLogo", fondo: "monitor"),
    CategoriasBuscador(nombreCategoria: "Teclado", artwork: "tecladoLogo", fondo: "teclado"),
    CategoriasBuscador(nombreCategoria: "Ratón", artwork: "ratonLogo", fondo: "raton"),
    CategoriasBuscador(nombreCategoria: "Componentes PC", artwork: "pcLogo", fondo: "pc"),
    
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

struct MarcasBuscador: Identifiable {
    var id = UUID().uuidString
    var nombreCategoria: String
    var artwork: String
}

var marcas = [
    
    MarcasBuscador(nombreCategoria: "Logitech", artwork: "logitechLogo"),
    MarcasBuscador(nombreCategoria: "Razer", artwork: "razerLogo"),
    MarcasBuscador(nombreCategoria: "Corsair", artwork: "corsairLogo"),
    MarcasBuscador(nombreCategoria: "Lg", artwork: "lgLogo"),
]

