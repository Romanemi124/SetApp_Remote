//
//  GuardarPublicacionViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 24/4/22.
//

import Foundation
import UIKit

class GuardarPublicacionViewModel: ObservableObject {
    
    @Published var didUploadPublication = false
    
    let service = ServicioProducto()
    
    func uploadPublicacion(withImage image: UIImage, withCategoria categoria: String, withNombreProducto nombreProducto: String, withMarca marca: String, withValoracion valoracion: String, withCaracteristicas caracteristicas: String) {
        
        service.uploadPublication(image: image, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, caracteristicas: caracteristicas) { success in
            
            if success {
                self.didUploadPublication = true
            } else {
                
            }
        }
    }
    
}
