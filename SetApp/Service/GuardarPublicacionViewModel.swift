//
//  GuardarPublicacionViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 24/4/22.
//

import Foundation
import UIKit

class GuardarPublicacionViewModel: ObservableObject {
    
    let service = ServicioProducto()
    
    func uploadPublicacion(withCategoria categoria: String, withNombreProducto nombreProducto: String, withMarca marca: String, withValoracion valoracion: String, withCaracteristicas caracteristicas: String) {
        
        service.uploadPublication(/*image: UIImage,*/ categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, caracteristicas: caracteristicas)
    }
    
}
