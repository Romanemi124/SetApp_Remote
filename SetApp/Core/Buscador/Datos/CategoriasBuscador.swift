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
    CategoriasBuscador(nombreCategoria: "Ratón", artwork: "ratonLogo", fondo: "raton"),
    CategoriasBuscador(nombreCategoria: "Teclado", artwork: "tecladoLogo", fondo: "teclado"),
    CategoriasBuscador(nombreCategoria: "Auriculares", artwork: "pcLogo", fondo: "pc"),
    
    /*
    CategoriasBuscador(nombreCategoria: "Altavoz", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Micrófono", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Webcam/Cámara Web", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Mando", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Consola", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Juegos", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Racing", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "PC", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Componente PC", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Portátil", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Silla", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Mesa", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Alfombrilla", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Accesorios", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Almacenamiento", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Teléfono", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Tablet", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Audio", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Foto", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Video", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "TV", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Impresora", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Software", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Red", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Hogar", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Robótica", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Figura", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Reloj", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "Ocio y tiempo libre", artwork: "", fondo: ""),
    CategoriasBuscador(nombreCategoria: "", artwork: "", fondo: ""),
    */
]

struct MarcasBuscador: Identifiable {
    var id = UUID().uuidString
    var nombreMarca: String
    var artwork: String
}

var marcas = [
    
    MarcasBuscador(nombreMarca: "Logitech", artwork: "logitechLogo"),
    MarcasBuscador(nombreMarca: "Razer", artwork: "razerLogo"),
    MarcasBuscador(nombreMarca: "Corsair", artwork: "corsairLogo"),
    MarcasBuscador(nombreMarca: "Lg", artwork: "lgLogo"),
]

